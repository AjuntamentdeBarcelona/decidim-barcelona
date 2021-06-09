# frozen_string_literal: true

require "rails_helper"

describe "Succesful verification", type: :system do
  include ActiveSupport::Testing::TimeHelpers

  include_context "with ephemerable participation"

  let!(:project) { create(:project, budget: budget) }
  let(:budget) { create(:budget, component: component) }
  let(:manifest_name) { "budgets" }
  let(:ephemeral_participable_authorization) { "dummy_authorization_handler" }
  let(:ephemeral_participable_action) { "vote" }
  let(:ephemeral_participation_action_button_selector) { "#project-vote-button-#{project.id}" }

  before do
    register_workflows
    switch_to_host(organization.host)
    visit_component
  end

  context "when the user clicks the ephemeral participation button" do
    let(:session_duration) { 5.minutes }

    before do
      stub_const("#{Decidim::EphemeralParticipation::SessionPresenter}::EPHEMERAL_PARTICIPANT_SESSION_DURATION", session_duration)
      click_ephemeral_participation_button
    end

    it "closes the session and redirects to root_path when the ephemeral session expires" do
      travel(session_duration) do
        visit(decidim.root_path)

        within_flash_messages do
          expect(page).to have_content("en.decidim.ephemeral_participation.ephemeral_participants.destroy")
        end

        expect(page).to have_current_path(decidim.root_path)
      end
    end
  end
end
