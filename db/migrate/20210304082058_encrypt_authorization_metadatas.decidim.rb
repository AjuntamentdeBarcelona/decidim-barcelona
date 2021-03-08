# frozen_string_literal: true
# This migration comes from decidim (originally 20201127114444)

class EncryptAuthorizationMetadatas < ActiveRecord::Migration[5.2]
  def up
    Decidim::Authorization.find_each do |auth|
      # Re-setting these values will internally convert the hash values to
      # encypted values
      p "#{auth.name}: #{auth.id}"
      auth.update!(
        metadata: auth.metadata,
        verification_metadata: auth.verification_metadata
      )
    end
  end

  def down
    Decidim::Authorization.find_each do |auth|
      # rubocop:disable Rails/SkipsModelValidations
      p "#{auth.name}: #{auth.id}"
      auth.update_columns(
        metadata: decrypt_hash(auth.metadata),
        verification_metadata: decrypt_hash(auth.verification_metadata)
      )
      # rubocop:enable Rails/SkipsModelValidations
    end
  end

  private

  def decrypt_hash(hash)
    hash.transform_values do |value|
      ActiveSupport::JSON.decode(Decidim::AttributeEncryptor.decrypt(value))
    rescue ActiveSupport::MessageEncryptor::InvalidMessage, ActiveSupport::MessageVerifier::InvalidSignature
      value
    end
  end
end
