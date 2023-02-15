# frozen_string_literal: true

require "rails_helper"

describe SmsGateway do
  subject { gateway }

  let(:gateway) { described_class.new(mobile_phone_number, code) }
  let(:mobile_phone_number) { "600102030" }
  let(:code) { "123456" }

  context "with a valid response" do
    before do
      allow(gateway)
        .to receive(:response)
        .and_return(Nokogiri::XML("<?xml version=\"1.0\" encoding=\"ISO-8859-1\" standalone=\"no\"?>\n<Envelope>\n  <Header>\n    <VODHeader>\n      <commandId>ACK</commandId>\n    </VODHeader>\n  </Header>\n  <Body>\n    <VODBody version=\"1.0\">\n      <contextID>SOME_CONTEXT_ID</contextID>\n    </VODBody>\n  </Body>\n</Envelope>\n"))
    end

    describe "deliver_code" do
      it "returns true" do
        expect(subject.deliver_code).to be_truthy
      end
    end

    describe "text" do
      it "builds a meaningful text" do
        expect(subject.text).to eq("Your code to be verified at Decidim Barcelona is: 123456")
      end
    end
  end

  context "with an invalid response" do
    before do
      allow(gateway)
        .to receive(:response)
        .and_return(Nokogiri::XML("<?xml version=\"1.0\" encoding=\"ISO-8859-1\" standalone=\"no\"?>\n<Envelope>\n  <Header>\n    <VODHeader>\n      <commandId>NACK</commandId>\n    </VODHeader>\n  </Header>\n  <Body>\n    <VODBody version=\"1.0\">\n      <contextID>HT1-01544693471198598</contextID>\n    </VODBody>\n    <Fault>\n      <faultactor>Client</faultactor>\n      <faultcode>985</faultcode>\n      <faultstring>Direccion IP incorrecta</faultstring>\n    </Fault>\n  </Body>\n</Envelope>\n").remove_namespaces!)
    end

    describe "deliver_code" do
      it "returns false" do
        expect(subject.deliver_code).to be_falsey
      end
    end
  end
end
