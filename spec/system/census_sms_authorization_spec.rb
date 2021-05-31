# frozen_string_literal: true

require "rails_helper"

describe "Census + SMS authorization", type: :system, perform_enqueued: true, with_authorization_workflows: ["census_sms_authorization_handler"] do
  let(:organization) do
    create(
      :organization,
      name: "Ajuntament",
      default_locale: :ca,
      available_locales: [:es, :ca],
      available_authorizations: authorizations
    )
  end

  let(:document_number) { "12345678A" }
  let(:authorization_name) { "El padró + SMS" }
  let(:authorizations) { { "census_sms_authorization_handler" => { "allow_ephemeral_participation" => true } } }
  let(:code) { user_authorization.verification_metadata["verification_code"] }
  let(:user_authorization) { Decidim::Authorization.find_by(user: user, name: "census_sms_authorization_handler") }

  let!(:scope) { create :scope, organization: organization, code: "1" }

  let(:response) do
    Nokogiri::XML("<codiRetorn>01</codiRetorn>").remove_namespaces!
  end

  # Selects a birth date that will not cause errors in the form: January 12, 1979.
  def fill_in_authorization_form
    select "DNI", from: "authorization_document_type"
    fill_in "authorization_document_number", with: document_number
    select "12", from: "authorization_date_of_birth_3i"
    select "Gener", from: "authorization_date_of_birth_2i"
    select "1979", from: "authorization_date_of_birth_1i"
    fill_in "authorization_postal_code", with: "08001"
    fill_in "authorization_mobile_phone_number", with: "(+34) 654 321 987"
    check "authorization_tos_acceptance"
    select translated(scope.name), from: "authorization_scope_id"
  end

  before do
    allow_any_instance_of(Decidim::CensusSms::Verification::AuthorizationForm).to receive(:response).and_return(response)
    switch_to_host(organization.host)
  end

  context "when visiting authorizations" do
    let(:user) { create(:user, :confirmed, organization: organization) }

    before do
      login_as user, scope: :user
      visit decidim.root_path
    end

    it "allows the user to authorize against available authorizations" do
      within_user_menu do
        click_link "El meu compte"
      end

      click_link "Autoritzacions"
      click_link authorization_name

      fill_in_authorization_form
      click_button "Verifica't"

      expect(page).to have_content("Has completat el primer pas")

      fill_in "confirmation_verification_code", with: code
      click_button "Verifica't"

      expect(page).to have_content("T'has verificat correctament")

      visit decidim_verifications.authorizations_path

      within ".authorizations-list" do
        expect(page).to have_content(authorization_name)
        expect(page).not_to have_link(authorization_name)
      end
    end

    it "allows the user to reset the verification code" do
      within_user_menu do
        click_link "El meu compte"
      end

      click_link "Autoritzacions"
      click_link authorization_name

      fill_in_authorization_form
      click_button "Verifica't"

      click_link "Restableix el codi de verificació"

      fill_in "reset[mobile_phone_number]", with: "(+34) 654 321 987"
      click_button "Envia'm un nou codi"

      expect(page).to have_content("T'hem enviat un nou codi de verificació")

      fill_in "confirmation_verification_code", with: code
      click_button "Verifica't"

      expect(page).to have_content("T'has verificat correctament")

      visit decidim_verifications.authorizations_path

      within ".authorizations-list" do
        expect(page).to have_content(authorization_name)
        expect(page).not_to have_link(authorization_name)
      end
    end

    context "when the user has completed the first authorization step" do
      let!(:code) { "012345" }
      let!(:authorization) { create(:authorization, :pending, name: "census_sms_authorization_handler", user: user, verification_metadata: { verification_code: code, code_sent_at: Time.current }) }

      it "can resume the authorization" do
        visit decidim_verifications.authorizations_path

        click_link authorization_name

        expect(page).to have_content("Introdueix el codi")

        fill_in "confirmation_verification_code", with: code
        click_button "Verifica't"

        expect(page).to have_content("T'has verificat correctament")
      end
    end

    context "when the user has already been authorised" do
      let!(:authorization) { create(:authorization, name: "census_sms_authorization_handler", user: user) }

      it "shows the authorization at their account" do
        visit decidim_verifications.authorizations_path

        within ".authorizations-list" do
          expect(page).to have_content(authorization_name)
          expect(page).to have_content(I18n.localize(authorization.granted_at, format: :long, locale: :ca))
        end
      end
    end
  end

  context "when trying to authorize another user with previously used information" do
    let!(:authorization) { create(:authorization, name: "census_sms_authorization_handler", unique_id: unique_id, organization: organization) }
    let!(:user) { create(:user, :confirmed, organization: organization) }
    let(:unique_id) do
      Digest::MD5.hexdigest(
        "#{document_number}-#{Rails.application.secrets.secret_key_base}"
      )
    end

    before do
      sign_in user
      visit decidim_verifications.authorizations_path
    end

    it "throws an error" do
      click_link authorization_name
      fill_in_authorization_form
      click_button "Verifica't"

      expect(page).to have_content("Ja hi ha una participant autoritzada amb les mateixes dades")
      expect(page).not_to have_content("Restableix el codi de verificació")
    end
  end
end
