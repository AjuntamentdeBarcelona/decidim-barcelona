# frozen_string_literal: true
# Checks the authorization against the census for Barcelona.
class CensusAuthorizationHandler < Decidim::AuthorizationHandler
  include ActionView::Helpers::SanitizeHelper

  attribute :document_number, String
  attribute :document_type, String
  attribute :postal_code, String
  attribute :date_of_birth, Date

  validates :document_number, :document_type, :postal_code, :date_of_birth,
            presence: true
  validates :document_type, inclusion: { in: %w{dni nie passport} }

  # The only method that needs to be implemented for an authorization handler.
  # Here you can add your business logic to check if the authorization should
  # be created or not, you should return a Boolean value.
  def authorized?
    valid? && response.xpath("//codiRetorn").text == "01"
  end

  # If you need to store any of the defined attributes in the authorization you
  # can do it here.
  #
  # You must return a Hash that will be serialized to the authorization when
  # it's created, and available though authorization.metadata
  def metadata
    super.merge(postal_code: postal_code)
  end

  def census_document_types
    %i{dni nie passport}.map do |type|
      [I18n.t(type, scope: "decidim.census_authorization_handler.document_types"), type]
    end
  end

  private

  def response
    return @response if defined?(@response)

    response ||= Faraday.post Rails.application.secrets.census_url do |request|
      request.headers["Content-Type"] = "text/xml"
      request.body = request_body
    end

    @response ||= Nokogiri::XML(response.body).remove_namespaces!
  end

  def sanitized_document_type
    case document_type.to_sym
    when :dni
      "01"
    when :passport
      "02"
    when :nie
      "03"
    else
      nil
    end
  end

  def sanitized_date_of_birth
    @sanitized_date_of_birth ||= date_of_birth.strftime("%Y%m%d")
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
        <sch:docId>#{sanitize document_number}</sch:docId>
        <sch:codiPostal>#{sanitize postal_code}</sch:codiPostal>
        <sch:dataNaixConst>#{sanitized_date_of_birth}</sch:dataNaixConst>
      </sch:Dades>
    </sch:GetPersonaLocalitzaAdrecaRequest>
  </soapenv:Body>
</soapenv:Envelope>
EOS
  end
end
