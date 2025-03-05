# frozen_string_literal: true

require "rails_helper"

describe "Authorizations", :perform_enqueued, with_authorization_workflows: ["census_sms_authorization_handler"] do
  include_context "with ephemerable participation"
  include_context "with census sms handler"

  let!(:organization) do
    create(
      :organization,
      name: { ca: "Ajuntament", es: "Ayuntamiento" },
      default_locale: :ca,
      available_locales: [:es, :ca],
      available_authorizations: authorizations
    )
  end

  let(:manifest_name) { "budgets" }
  let(:ephemerable_authorization) { "census_sms_authorization_handler" }
  let(:ephemerable_action) { "vote" }

  let(:budget) { create(:budget, component:, total_budget: 50_000_000) }
  let!(:projects) { create_list(:project, 3, budget:, budget_amount: 25_000_000) }

  let!(:scope) { create(:scope, organization:, code: "1") }

  before do
    switch_to_host(organization.host)
    visit_component
  end

  describe "ephemeral participation" do
    context "when trying to perform an authorized action with ephemeral participation enabled" do
      before do
        page.find("#project-vote-button-#{projects.first.id}").click
      end

      xit "shows the ephemeral participation button" do
        expect(page).to have_button("Vull participar")
      end

      xit "renders the right links and messages" do
        click_on "Vull participar"

        expect(page).to have_content("Per poder participar sense registre, has de completar el procés de verificació")

        get_verified

        expect(page).to have_content("Felicitats!")
      end

      # context "when re-entering the same data" do
      #   let!(:previous_authorization) {  }
      #   let(:managed_user) { create :user, managed: true, organization: organization }
      #   before do

      #   end

      #   xit "shows an error message" do
      #     click_on "Vull participar"

      #     get_verified

      #     page.find(".focus-mode__close").click

      #     within_user_menu do
      #       page.find(".sign-out-link").click
      #     end

      #     # byebug
      #   end
      # end
    end
  end
end
