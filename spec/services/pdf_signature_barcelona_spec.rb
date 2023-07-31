# frozen_string_literal: true

require "rails_helper"

describe PdfSignatureBarcelona do
  subject { service }

  let(:service) { described_class.new(params) }
  let(:params) { { pdf: valid_pdf } }
  let(:valid_pdf) { File.read("spec/fixtures/example_pdf.pdf") }

  describe "#signed_pdf" do
    subject { service.signed_pdf }

    context "when a configuration variable is missing" do
      before do
        allow(service).to receive(:pdf_certificate).and_return(nil)
      end

      it "returns the same pdf received" do
        expect(subject).to eq(valid_pdf)
      end
    end

    context "when configuration variables are present and the certificates valid" do
      let(:key) { OpenSSL::PKey::RSA.new(2048) }
      let(:certificate) do
        OpenSSL::X509::Certificate.new.tap do |cert|
          cert.not_before = Time.current
          cert.not_after = 10.years.from_now
          cert.public_key = key.public_key
          cert.sign(key, OpenSSL::Digest.new("SHA256"))
        end
      end
      let(:private_key) { double("private_key", key: key) }

      before do
        allow(service).to receive(:certificate).and_return(certificate)
        allow(service).to receive(:private_key).and_return(private_key)
        allow(service).to receive(:missing_configuration?).and_return(false)
      end

      context "with a valid pdf" do
        it "returns a signed pdf with a page added" do
          original_pdf = Origami::PDF.read("spec/fixtures/example_pdf.pdf")
          output_pdf = Origami::PDF.read(StringIO.new(subject))
          expect(original_pdf.pages.count).to eq(1)
          expect(original_pdf.signed?).to be false
          expect(output_pdf.pages.count).to eq(2)
          expect(output_pdf.signed?).to be true
        end
      end

      context "with an invalid pdf" do
        let(:params) { { pdf: "wadus" } }

        it { expect { subject }.to raise_error(StandardError) }
      end
    end
  end
end
