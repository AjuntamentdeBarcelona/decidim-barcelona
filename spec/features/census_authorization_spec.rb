# frozen_string_literal: true

require "rails_helper"

describe "Authorizations", type: :feature, perform_enqueued: true do
  let(:organization) { create :organization, available_authorizations: authorizations }
  let!(:scope) { create :scope, organization: organization, code: "1" }
  let(:authorizations) { ["CensusAuthorizationHandler"] }
  let(:response) do
    Nokogiri::XML("<codiRetorn>01</codiRetorn>").remove_namespaces!
  end

  # Selects a birth date that will not cause errors in the form: January 12, 1979.
  def fill_in_authorization_form
    select "DNI", from: "authorization_handler_document_type"
    fill_in "authorization_handler_document_number", with: "12345678A"
    select "12", from: "authorization_handler_date_of_birth_3i"
    select "January", from: "authorization_handler_date_of_birth_2i"
    select "1979", from: "authorization_handler_date_of_birth_1i"
    fill_in "authorization_handler_postal_code", with: "08001"
    select translated(scope.name), from: "authorization_handler_scope_id"
  end

  before do
    Decidim.authorization_handlers = ["CensusAuthorizationHandler"]
    allow_any_instance_of(CensusAuthorizationHandler).to receive(:response).and_return(response)
    switch_to_host(organization.host)
  end

  context "a new user" do
    let(:user) { create(:user, :confirmed, organization: organization) }

    context "when one authorization has been configured" do
      before do
        visit decidim.root_path
        find(".sign-in-link").click

        within "form.new_user" do
          fill_in :user_email, with: user.email
          fill_in :user_password, with: "password1234"
          find("*[type=submit]").click
        end
      end

      it "redirects the user to the authorization form after the first sign in" do
        fill_in_authorization_form
        click_button "Send"
        expect(page).to have_content("successfully")
      end

      it "allows the user to skip it" do
        find(".skip a").click
        expect(page).to have_content("User settings")
      end
    end
  end

  context "user account" do
    let(:user) { create(:user, :confirmed) }

    before do
      login_as user, scope: :user
      visit decidim.root_path

      allow(PostalCodeDistricts).to receive(:valid?).and_return(true)
    end

    it "allows the user to authorize against available authorizations" do
      visit decidim.new_authorization_path(handler: "census_authorization_handler")

      fill_in_authorization_form
      click_button "Send"

      expect(page).to have_content("successfully")

      visit decidim.authorizations_path

      within ".authorizations-list" do
        expect(page).to have_content("El padró")
        expect(page).not_to have_link("El padró")
      end
    end

    context "when the user has already been authorised" do
      let!(:authorization) do
        create(:authorization,
               name: CensusAuthorizationHandler.handler_name,
               user: user)
      end

      it "shows the authorization at their account" do
        visit decidim.authorizations_path

        within ".authorizations-list" do
          expect(page).to have_content("El padró")
          expect(page).not_to have_link("El padró")
          expect(page).to have_content(I18n.localize(authorization.created_at, format: :long))
        end
      end
    end
  end
end
