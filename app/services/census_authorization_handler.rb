# frozen_string_literal: true
# Checks the authorization against the census for Barcelona.
require "digest/md5"

# This class performs a check against the official census database in order
# to verify the citizen's residence.
class CensusAuthorizationHandler < Decidim::AuthorizationHandler
  include ActionView::Helpers::SanitizeHelper
  include Virtus::Multiparams

  AVAILABLE_GENDERS = %w(man woman non_binary)

  attribute :document_number, String
  attribute :document_type, Symbol
  attribute :postal_code, String
  attribute :scope_id, Integer
  attribute :date_of_birth, Date
  attribute :gender, String

  validates :date_of_birth, presence: true
  validates :document_type, inclusion: { in: %i(dni nie passport) }, presence: true
  validates :document_number, format: { with: /\A[A-z0-9]*\z/ }, presence: true
  validates :postal_code, presence: true, format: { with: /\A[0-9]*\z/ }
  validates :scope_id, presence: true

  validate :document_type_valid
  validate :age_limit
  validate :valid_postal_code

  # If you need to store any of the defined attributes in the authorization you
  # can do it here.
  #
  # You must return a Hash that will be serialized to the authorization when
  # it's created, and available though authorization.metadata
  def metadata
    super.merge(
      date_of_birth: date_of_birth&.strftime("%Y-%m-%d"),
      postal_code: postal_code,
      scope: scope.name["ca"],
      scope_id: scope.id,
      extras: {
        gender: gender
      }
    )
  end

  def scope
    Decidim::Scope.find(scope_id)
  end

  def census_document_types
    %i(dni nie passport).map do |type|
      [I18n.t(type, scope: "decidim.census_authorization_handler.document_types"), type]
    end
  end

  def unique_id
    Digest::MD5.hexdigest(
      "#{sanitized_document_number}-#{Rails.application.secrets.secret_key_base}"
    )
  end

  private

  def sanitized_document_type
    case document_type&.to_sym
    when :dni
      "01"
    when :passport
      "02"
    when :nie
      "03"
    end
  end

  def sanitized_date_of_birth
    @sanitized_date_of_birth ||= date_of_birth&.strftime("%Y%m%d")
  end

  def document_type_valid
    return nil if response.blank?

    errors.add(:document_number, I18n.t("census_authorization_handler.invalid_document")) unless response.xpath("//codiRetorn").text == "01"
  end

  def sanitized_document_number
    document_number&.gsub(/[^A-Za-z0-9]/, "")&.upcase
  end

  def response
    return nil if document_number.blank? ||
                  document_type.blank? ||
                  postal_code.blank? ||
                  date_of_birth.blank?

    return @response if defined?(@response)

    response ||= Faraday.post Rails.application.secrets.census_url do |request|
      request.headers["Content-Type"] = "text/xml"
      request.body = request_body
    end

    @response ||= Nokogiri::XML(response.body).remove_namespaces!
  end


  def request_body
    @request_body ||= <<EOS
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:sch="http://es.bcn.mci.ws/cr/schemas">
  <soapenv:Header/>
  <soapenv:Body>
    <sch:GetPersonaLocalitzaAdrecaRequest>
      <sch:usuari>PAM</sch:usuari>
      <sch:Dades>
        <sch:tipDocument>#{sanitized_document_type}</sch:tipDocument>
        <sch:docId>#{sanitized_document_number}</sch:docId>
        <sch:codiPostal>#{sanitize postal_code}</sch:codiPostal>
        <sch:dataNaixConst>#{sanitized_date_of_birth}</sch:dataNaixConst>
      </sch:Dades>
    </sch:GetPersonaLocalitzaAdrecaRequest>
  </soapenv:Body>
</soapenv:Envelope>
EOS
  end

  def age_limit
    errors.add(:date_of_birth, I18n.t("census_authorization_handler.age_under", min_age: 14)) unless age && age >= 14
  end

  def age
    return nil if date_of_birth.blank?

    now = Date.current
    extra_year = (now.month > date_of_birth.month) || (
      now.month == date_of_birth.month && now.day >= date_of_birth.day
    )

    now.year - date_of_birth.year - (extra_year ? 0 : 1)
  end

  def valid_postal_code
    errors.add(:postal_code, :not_in_district) unless PostalCodeDistricts.valid?(postal_code, scope.code)
  end
end
