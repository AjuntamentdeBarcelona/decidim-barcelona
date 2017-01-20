# frozen_string_literal: true
require "rails_helper"
require "decidim/dev/test/authorization_shared_examples"

describe CensusAuthorizationHandler do
  let(:subject) { handler }
  let(:handler) { described_class.new(params) }
  let(:document_number) { "12345678A" }
  let(:document_type) { :nie }
  let(:postal_code) { "08001" }
  let(:date_of_birth) { Date.civil(1987, 9, 17) }
  let(:params) do
    {
      document_number: document_number,
      document_type: document_type,
      postal_code: postal_code,
      date_of_birth: date_of_birth
    }
  end

  it_behaves_like "an authorization handler"

  context "with a valid response" do
    before do
      allow(handler)
        .to receive(:response)
              .and_return(Nokogiri::XML("<codiRetorn>01</codiRetorn>").remove_namespaces!)
    end

    context "without a document number" do
      let(:document_number) { nil }

      it { is_expected.not_to be_valid }
    end

    context "without a document type" do
      let(:document_type) { nil }

      it { is_expected.not_to be_valid }
    end

    context "when document type has a weird value" do
      let(:document_type) { :driver_license }

      it { is_expected.not_to be_valid }
    end

    context "without a postal_code" do
      let(:postal_code) { nil }

      it { is_expected.not_to be_valid }
    end

    context "without a document number" do
      let(:date_of_birth) { nil }

      it { is_expected.not_to be_valid }
    end

    context "when everything is fine" do
      it { is_expected.to be_valid }
    end
  end

  context "with an invalid response" do
    before do
      allow(handler)
        .to receive(:response)
        .and_return(Nokogiri::XML("Messed up response!").remove_namespaces!)
    end

    it { is_expected.to_not be_valid }
  end
end
