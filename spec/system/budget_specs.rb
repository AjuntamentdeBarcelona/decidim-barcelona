# frozen_string_literal: true

require "rails_helper"

describe "Budgets", type: :system, perform_enqueued: true, available_authorizations: ["census_sms_authorization_handler"] do
  include_context "with ephemerable participation" do
    include_context "with census sms handler"

    let!(:organization) do
      create(
        :organization,
        name: "Ajuntament",
        default_locale: :ca,
        available_locales: [:es, :ca],
        available_authorizations: authorizations
      )
    end

    let(:manifest_name) { "budgets" }

    let(:authorizations) { ["census_sms_authorization_handler"] }
    let(:ephemerable_authorization) { "census_sms_authorization_handler" }
    let(:ephemerable_action) { "vote" }

    let(:budget) { create :budget, component: component, total_budget: 50_000_000 }
    let!(:projects) { create_list(:project, 3, budget: budget, budget_amount: 25_000_000) }

    let!(:scope) { create :scope, organization: organization, code: "1" }

    let!(:user) { create(:user, :confirmed, organization: organization) }

    before do
      switch_to_host(organization.host)
      login_as user, scope: :user
      visit_component
    end

    context "when an unverified user tries to add a project to budget order" do
      before do
        visit Decidim::EngineRouter.main_proxy(component).budget_projects_path(budget)
      end

      it "correctly redirects after user verifies" do
        page.find("#project-vote-button-#{projects.first.id}").click

        expect(page).to have_selector("#authorizationModal")

        click_on "Autoritzar"

        get_verified

        expect(page).to have_content(translated(projects.first.title))
        expect(page).to have_content(translated(projects.second.title))
      end
    end
  end
end
