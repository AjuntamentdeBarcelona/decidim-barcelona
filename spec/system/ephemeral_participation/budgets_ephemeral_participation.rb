# frozen_string_literal: true

require "rails_helper"
require "decidim/budgets/test/factories"

describe "Authorizations", type: :system, perform_enqueued: true, with_authorization_workflows: ["census_sms_authorization_handler"] do
  let!(:organization) do
    create(
      :organization,
      name: "Ajuntament",
      default_locale: :ca,
      available_locales: [:es, :ca],
      available_authorizations: authorizations
    )
  end

  let(:authorizations) { { "census_sms_authorization_handler" => { "allow_ephemeral_participation" => true } } }
  let!(:scope) { create :scope, organization: organization, code: "1" }

  let(:component) do
    create(:budgets_component,
           :with_minimum_budget_projects,
           organization: organization,
           settings: settings,
           permissions: permissions)
  end

  let(:permissions) { {} }
  let(:settings) { {} }

  let(:budget) { create :budget, component: component, total_budget: 50_000_000 }
  let!(:projects) { create_list(:project, 3, budget: budget, budget_amount: 25_000_000) }

  let(:response) do
    Nokogiri::XML("<codiRetorn>01</codiRetorn>").remove_namespaces!
  end

  let(:code) { Decidim::Authorization.last.verification_metadata["verification_code"] }
  let(:user) { Decidim::User.last }

  # Selects a birth date that will not cause errors in the form: January 12, 1979.
  def fill_in_authorization_form
    select "DNI", from: "authorization_document_type"
    fill_in "authorization_document_number", with: "12345678A"
    select "12", from: "authorization_date_of_birth_3i"
    select "Gener", from: "authorization_date_of_birth_2i"
    select "1979", from: "authorization_date_of_birth_1i"
    fill_in "authorization_postal_code", with: "08001"
    fill_in "authorization_mobile_phone_number", with: "(+34) 654 321 987"
    check "authorization_tos_acceptance"
    select translated(scope.name), from: "authorization_scope_id"
  end

  def get_verified
    fill_in_authorization_form
    click_button "Verifica't"

    fill_in "confirmation_verification_code", with: code
    click_button "Verifica't"
  end

  before do
    allow_any_instance_of(Decidim::CensusSms::Verification::AuthorizationForm).to receive(:response).and_return(response)
    switch_to_host(organization.host)
  end

  describe "ephemeral participation" do
    before do
      visit Decidim::EngineRouter.main_proxy(component).budget_path(budget)
    end

    context "when trying to perform an authorized action with ephemeral participation enabled" do
      let(:permissions) { { "vote" => { "authorization_handlers" => { "census_sms_authorization_handler" => {} } } } }
      let(:settings) { { ephemeral_participation_enabled: true } }

      before do
        page.find("#project-vote-button-#{projects.first.id}").click
      end

      it "shows the ephemeral participation button" do
        expect(page).to have_button("Vull participar")
      end

      it "renders the right links and messages" do
        click_button "Vull participar"
        
        expect(page).to have_content("Per poder participar sense registre, has de completar el procés de verificació")

        get_verified
        
        expect(page).to have_content("Felicitats!")
      end
    end
  end
end
