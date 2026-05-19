# frozen_string_literal: true

# Adds backward compatibility for Active Storage signed URLs created before
# the upgrade to Rails 7.2 (Decidim 0.31).
#
# load_defaults 7.2 sets key_generator_hash_digest_class to SHA256, but old
# signed blob URLs embedded in content fields were signed with SHA1-derived
# keys. Without rotation, those URLs return 404.
#
# This keeps SHA256 for new signatures while accepting old SHA1 signatures.
Rails.application.config.after_initialize do
  next if Rails.application.secret_key_base.blank?

  old_secret = ActiveSupport::KeyGenerator.new(
    Rails.application.secret_key_base,
    iterations: 1000,
    hash_digest_class: OpenSSL::Digest::SHA1
  ).generate_key("ActiveStorage")

  new_secret = Rails.application.key_generator.generate_key("ActiveStorage")

  verifier = ActiveSupport::MessageVerifier.new(new_secret)
  verifier.rotate(old_secret)

  ActiveStorage::Blob.instance_variable_set(:@signed_id_verifier, verifier)
end
