# frozen_string_literal: true

require "rails_helper"

describe "Authorizations", :perform_enqueued, with_authorization_workflows: ["census_authorization_handler"] do
  let(:organization) do
    create(
      :organization,
      name: { ca: "Ajuntament", es: "Ayuntamiento" },
      default_locale: :ca,
      available_locales: [:es, :ca],
      available_authorizations: authorizations
    )
  end

  let(:authorizations) { ["census_authorization_handler"] }
  let!(:scope) { create(:scope, organization:, code: "1") }

  let(:response) do
    Nokogiri::XML("<codiRetorn>01</codiRetorn>").remove_namespaces!
  end

  # Selects a birth date that will not cause errors in the form: January 12, 1979.
  def fill_in_authorization_form
    select "DNI", from: "authorization_handler_document_type"
    fill_in "authorization_handler_document_number", with: "12345678A"
    select "12", from: "authorization_handler_date_of_birth_3i"
    select "Gener", from: "authorization_handler_date_of_birth_2i"
    select "1979", from: "authorization_handler_date_of_birth_1i"
    fill_in "authorization_handler_postal_code", with: "08001"
    select translated(scope.name), from: "authorization_handler_scope_id"
  end

  before do
    # rubocop:disable RSpec/AnyInstance
    allow_any_instance_of(CensusAuthorizationHandler).to receive(:response).and_return(response)
    # rubocop:enable RSpec/AnyInstance
    switch_to_host(organization.host)
  end

  context "when user account" do
    let(:user) { create(:user, :confirmed, organization:) }

    before do
      login_as user, scope: :user
      visit decidim.root_path
    end

    it "allows the user to authorize against available authorizations" do
      skip "Capybara driver is not able to handle the form submission in this case"

      within_user_menu do
        click_on "El meu compte"
      end

      click_on "Autoritzacions"
      click_on "El padró"

      fill_in_authorization_form
      click_on "Enviar"

      expect(page).to have_content("Se t'ha autoritzat correctament")

      visit decidim_verifications.authorizations_path

      within ".authorizations-list" do
        expect(page).to have_content("El padró")
        expect(page).to have_no_link("El padró")
      end
    end

    context "when the user has already been authorised" do
      let!(:authorization) do
        create(:authorization,
               name: CensusAuthorizationHandler.handler_name,
               user:)
      end

      it "shows the authorization at their account" do
        visit decidim_verifications.authorizations_path

        within ".authorizations-list" do
          expect(page).to have_content("El padró")
          expect(page).to have_content(I18n.l(authorization.granted_at, format: :long_with_particles, locale: :ca))
        end
      end
    end
  end
end
