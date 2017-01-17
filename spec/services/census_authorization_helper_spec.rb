# frozen_string_literal: true
require "rails_helper"
require "decidim/dev/test/authorization_shared_examples"

describe CensusAuthorizationHandler do
  let(:handler) { described_class.new(params) }
  let(:params) do
    {
      document_number: "12345678A",
      document_type: :nie,
      postal_code: "08001",
      date_of_birth: Date.civil(1987, 9, 17)
    }
  end

  before do
    allow(handler)
      .to receive(:response)
      .and_return(Nokogiri::XML("<codiRetorn>01</codiRetorn>").remove_namespaces!)
  end

  it_behaves_like "an authorization handler"
end
