# frozen_string_literal: true

# Signature handler that collects census data and delegates validation to CensusAuthorizationHandler
class CensusSignatureHandler < Decidim::Initiatives::SignatureHandler
  AVAILABLE_GENDERS = %w(man woman non_binary).freeze

  attribute :document_number, String
  attribute :document_type, Symbol
  attribute :postal_code, String
  attribute :scope_id, Integer
  attribute :date_of_birth, Date
  attribute :gender, String

  def metadata
    {
      document_number: sanitized_document_number,
      document_type:,
      postal_code: sanitized_postal_code,
      scope_id:,
      date_of_birth: date_of_birth&.strftime("%Y-%m-%d"),
      gender:
    }
  end

  def census_document_types
    [:dni, :nie, :passport].map do |type|
      [I18n.t(type, scope: "decidim.census_authorization_handler.document_types"), type]
    end
  end

  def unique_id
    Digest::MD5.hexdigest(
      "#{sanitized_document_number}-#{Rails.application.secret_key_base}"
    )
  end

  def sanitized_postal_code
    postal_code&.gsub(/[^0-9]/, "")
  end

  # When there's a document number, sanitize it allowing only numbers.
  def sanitized_document_number
    document_number&.gsub(/[^A-Za-z0-9]/, "")&.upcase
  end

  def signature_scope_id
    scope_id
  end

  def self.requires_extra_attributes?
    true
  end
end
