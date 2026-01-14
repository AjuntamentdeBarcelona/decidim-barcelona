# frozen_string_literal: true

# A Service to send SMS to Barcelona's provider so users can be verified by SMS.
class SmsGateway
  attr_reader :mobile_phone_number, :code, :context

  def initialize(mobile_phone_number, code, context = {})
    @mobile_phone_number = mobile_phone_number
    @code = code
    @context = context
  end

  def deliver_code
    if response.xpath("//Fault").present?
      report_error
      false
    else
      true
    end
  end

  def response
    return @response if defined?(@response)

    Faraday.ignore_env_proxy = true
    connection = Faraday.new(Decidim::Env.new("SMS_SERVICE_URL").to_s, proxy: Decidim::Env.new("SMS_PROXY_URL").to_s)
    response = connection.post do |request|
      request.headers["Content-Type"] = "text/xml"
      request.body = request_body
    end

    @response ||= Nokogiri::XML(response.body).remove_namespaces!
  end

  def text
    I18n.t("decidim.sms.text", code:)
  end

  private

  def report_error
    return unless defined?(Raven)

    error = response.xpath("//faultstring").text

    Raven.capture_message("Error while sending an SMS: #{error}")
  end

  def request_body
    @request_body ||= <<~SOAP
      <?xml version="1.0" standalone="no"?>
      <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
      	<soapenv:Header>
      		<vodh:VODHeader xmlns:vodh="http://www.vodafone.com/soap/header/">
      			<vodh:commandId>ServiceDelivery</vodh:commandId>
      			<vodh:authentication>
            <vodh:username>#{Decidim::Env.new("SMS_USERNAME").to_s}</vodh:username>
            <vodh:password>#{Decidim::Env.new("SMS_PASSWORD").to_s}</vodh:password>
      			</vodh:authentication>
      			<vodh:service>
            <vodh:serviceID>#{Decidim::Env.new("SMS_SERVICE_ID").to_s}</vodh:serviceID>
      				<vodh:serviceType>SMS</vodh:serviceType>
      			</vodh:service>
      		</vodh:VODHeader>
      	</soapenv:Header>
      	<soapenv:Body>
      		<vodb:VODBody xmlns:vodb="http://www.vodafone.com/soap/body/" version="1.0">
      			<vodb:contextID></vodb:contextID >
      			<vodb:destAddress>#{mobile_phone_number}</vodb:destAddress>
      			<vodb:subServiceId>#{Decidim::Env.new("SMS_SUB_SERVICE_ID").to_s}</vodb:subServiceId>
            <vodb:messageBody>#{text}</vodb:messageBody>
      			<vodb:bodyIsText>true</vodb:bodyIsText>
      			<vodb:deliveryReport>false</vodb:deliveryReport>
      			<vodb:priorityFlag>0</vodb:priorityFlag>
      			<vodb:dataCodingScheme>0</vodb:dataCodingScheme>
      			<vodb:sourceTON>5</vodb:sourceTON>
      			<vodb:destTON>1</vodb:destTON>
      			<vodb:sourceNPI>0</vodb:sourceNPI>
      			<vodb:destNPI>1</vodb:destNPI>
      			<vodb:esmClass>0</vodb:esmClass>
      			<vodb:protocolId>0</vodb:protocolId>
      		</vodb:VODBody>
      	</soapenv:Body>
      </soapenv:Envelope>
    SOAP
  end
end
