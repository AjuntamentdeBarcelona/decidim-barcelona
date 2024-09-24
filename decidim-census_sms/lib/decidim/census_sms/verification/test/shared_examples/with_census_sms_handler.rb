# frozen_string_literal: true

shared_context "with census sms handler" do
  let(:authorization_document_number) { "12345678A" }
  let(:authorization_document_type) { "DNI" }
  let(:authorization_date_of_birth_year) { "1979" }
  let(:authorization_date_of_birth_month) { "Gener" }
  let(:authorization_date_of_birth_day) { "12" }
  let(:authorization_postal_code) { "08001" }
  let(:authorization_mobile_phone_number) { "(+34) 654 321 987" }
  let(:authorization_tos_acceptance) { true }
  let(:authorization_scope) { translated(scope.name) }

  let(:code) { Decidim::Authorization.last.verification_metadata["verification_code"] }

  let(:response) do
    Nokogiri::XML("<codiRetorn>01</codiRetorn>").remove_namespaces!
  end

  # Selects a birth date that will not cause errors in the form: January 12, 1979.
  def fill_in_authorization_form
    select authorization_document_type, from: "authorization_document_type"
    fill_in "authorization_document_number", with: authorization_document_number
    select authorization_date_of_birth_day, from: "authorization_date_of_birth_3i"
    select authorization_date_of_birth_month, from: "authorization_date_of_birth_2i"
    select authorization_date_of_birth_year, from: "authorization_date_of_birth_1i"
    fill_in "authorization_postal_code", with: authorization_postal_code
    fill_in "authorization_mobile_phone_number", with: authorization_mobile_phone_number
    check "authorization_tos_acceptance" if authorization_tos_acceptance
    select authorization_scope, from: "authorization_scope_id"
  end

  # rubocop:disable Naming/AccessorMethodName:
  def get_verified
    fill_in_authorization_form
    click_on "Verifica't"

    fill_in "confirmation_verification_code", with: code
    click_on "Verifica't"
  end
  # rubocop:enable Naming/AccessorMethodName:

  before do
    allow_any_instance_of(Decidim::CensusSms::Verification::AuthorizationForm).to receive(:response).and_return(response)
  end
end
