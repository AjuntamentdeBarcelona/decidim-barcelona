# frozen_string_literal: true

require "rails_helper"

describe "Ephemeral participation button" do
  include_context "with ephemerable participation"

  let!(:project) { create(:project, budget:) }
  let(:budget) { create(:budget, component:) }
  let(:manifest_name) { "budgets" }
  let(:ephemeral_participable_authorization) { "dummy_authorization_handler" }
  let(:ephemeral_participable_action) { "vote" }

  before do
    register_workflows
    switch_to_host(organization.host)
    visit_component
  end

  context "when trying to perform an authorized action with ephemeral participation enabled" do
    before do
      page.find("#project-vote-button-#{project.id}").click
    end

    it "shows the ephemeral participation button and help text" do
      expect(page).to have_button("I want to participate without registering")
      expect(page).to have_content("Use this option for a one-time participation")
    end

    context "when the component has ephemeral_participation_enabled_confirm_modal filled" do
      let(:settings) do
        {
          ephemeral_participation_enabled: true,
          ephemeral_participation_enabled_confirm_modal: { "en" => "<p>Are you sure?</p>" }
        }
      end

      it "renders the confirmation modal" do
        click_ephemeral_participation_login_button

        within("#confirm-modal-content") do
          expect(page).to have_content("Are you sure?")
        end
      end
    end

    context "when the component has not ephemeral_participation_enabled_confirm_modal filled" do
      let(:settings) do
        { ephemeral_participation_enabled: true }
      end

      it "renders the verification form directly" do
        click_ephemeral_participation_login_button

        within_flash_messages do
          expect(page).to have_content("en.decidim.ephemeral_participation.ephemeral_participants.create")
        end

        expect(page).to have_field("authorization_handler_document_number")
      end
    end
  end
end
