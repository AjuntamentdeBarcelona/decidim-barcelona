# frozen_string_literal: true

require "rails_helper"

describe TimestampService do
  let(:subject) { service }
  let(:service) { described_class.new(params) }
  let(:document) { "This is a test" }
  let(:params) { { document: document } }
  let(:endpoint) { "http://example.org" }
  let(:stubbed_response) { "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\"><soapenv:Body><dss:SignResponse Profile=\"urn:oasis:names:tc:dss:1.0:profiles:timestamping\" xmlns:dss=\"urn:oasis:names:tc:dss:1.0:core:schema\"><dss:Result><dss:ResultMajor>urn:oasis:names:tc:dss:1.0:resultmajor:Success</dss:ResultMajor><dss:ResultMessage xml:lang=\"en\">Signature created</dss:ResultMessage></dss:Result><dss:OptionalOutputs/><dss:SignatureObject><dss:Timestamp><dss:RFC3161TimeStampToken>Signature</dss:RFC3161TimeStampToken></dss:Timestamp></dss:SignatureObject></dss:SignResponse></soapenv:Body></soapenv:Envelope>" }

  before do
    allow(service).to receive(:timestamp_service_url).and_return(endpoint)
  end

  describe "#timestamp" do
    subject { service.timestamp }

    context "when timestamp service url is not set" do
      before do
        allow(service).to receive(:timestamp_service_url).and_return(nil)
      end

      context "when document is a string" do
        it "the service returns current datetime" do
          expect(Date.parse(subject)).to eq(Date.current)
        end
      end
    end

    context "when document is nil" do
      let(:document) { nil }

      it { is_expected.to be_nil }
    end

    context "when document is a string" do
      before do
        stub_request(:post, endpoint).
          with(
            body: service.send(:request_message),
            headers: {
              "Accept" => "*/*",
              "Accept-Encoding" => "gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
              "Content-Type" => "text/xml",
              "User-Agent" => "Faraday v0.15.4"
            }).
            to_return(status: 200, body: stubbed_response, headers: {})
      end

      context "without signature_type param" do
        context "when document is a string" do
          it { is_expected.to_not be_blank }
        end
      end

      context "with valid signature_type param" do
        let(:params) { { document: document, signature_type: :xml } }

        context "when document is a string" do
          it { is_expected.to_not be_blank }
        end
      end

      context "with invalid signature_type param" do
        let(:params) { { document: document, signature_type: :unknown } }

        context "when document is a string" do
          it { is_expected.to_not be_blank }
        end
      end
    end
  end
end
