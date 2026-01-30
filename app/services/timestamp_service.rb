# frozen_string_literal: true

# Service to generate a timestamp for a document provided by Consorci AOC
# (see https://www.aoc.cat/knowledge-base/documentacio-dintegracio-validador/)
#
class TimestampService
  attr_accessor :document

  # Public: Initializes the service.
  #
  # document - The document for which the timestamp is going to be generated
  # signature_type - Response format: xml, xades or cms. cms by default
  def initialize(args = {})
    @document = args.fetch(:document)
    @signature_type = args.fetch(:signature_type, :default)
  end

  # Public: Timestamp generated from data
  def timestamp
    return if @document.nil?

    @timestamp ||= timestamp_response
  end

  private

  SIGNATURE_TYPES = {
    xml: "OASIS:names:tc:dss:1.0:core:schema:XMLTimeStampToken",
    xades: "OASIS:names:tc:dss:1.0:core:schema:XAdESTimeStampToken",
    cms: "urn:ietf:rfc:3161",
    default: "urn:ietf:rfc:3161"
  }.freeze

  def request_message
    @request_message ||= <<~MESSAGE
      <SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/">
        <SOAP-ENV:Body>
          <dss:SignRequest xmlns:dss="urn:oasis:names:tc:dss:1.0:core:schema"
          Profile="urn:oasis:names:tc:dss:1.0:profiles:timestamping">
            <dss:OptionalInputs>
              <dss:IncludeObject WhichDocument="#{document_name}"
              hasObjectTagsAndAttributesSet="false"
              ObjId="obj#{document_name}" createReference="true"/>
              <dss:KeySelector>
                <ds:KeyInfo xmlns:ds="http://www.w3.org/2000/09/xmldsig#">
                  <ds:X509Data>
                    <ds:X509Certificate>
                    </ds:X509Certificate>
                  </ds:X509Data>
                </ds:KeyInfo>
              </dss:KeySelector>
              <dss:SignatureType>#{signature_type_protocol}</dss:SignatureType>
            </dss:OptionalInputs>
            <dss:InputDocuments>
              <dss:DocumentHash ID="#{document_name}">
                <ds:DigestMethod Algorithm="http://www.w3.org/2000/09/xmldsig#sha1"
                xmlns:ds="http://www.w3.org/2000/09/xmldsig#"/>
                <ds:DigestValue xmlns:ds="http://www.w3.org/2000/09/xmldsig#">#{document_digest}</ds:DigestValue>
              </dss:DocumentHash>
            </dss:InputDocuments>
          </dss:SignRequest>
        </SOAP-ENV:Body>
      </SOAP-ENV:Envelope>
    MESSAGE
  end

  def document_name
    @document_name ||= "Document"
  end

  def signature_type_protocol
    SIGNATURE_TYPES[@signature_type] || SIGNATURE_TYPES[:default]
  end

  def document_digest
    Base64.encode64(OpenSSL::Digest::SHA1.digest(@document)).chop
  end

  def timestamp_service_url
    Decidim::Env.new("TIMESTAMP_SERVICE_URL").to_s.presence
  end

  def skip_ssl_verification?
    Decidim::Env.new("TIMESTAMP_SERVICE_SKIP_SSL").present?
  end

  def timestamp_response
    return Time.current.to_s unless timestamp_service_url

    connection = Faraday.new do |faraday|
      faraday.ssl.verify = false if skip_ssl_verification?
    end

    resp = connection.post(timestamp_service_url) do |request|
      request.headers["Content-Type"] = "text/xml"
      request.body = request_message
    end

    parsed_response = Nokogiri::XML(resp.body).remove_namespaces!

    return resp.body if parsed_response.xpath("//ResultMessage").first&.content == "Signature created"

    "Timestamp failed"
  end
end
