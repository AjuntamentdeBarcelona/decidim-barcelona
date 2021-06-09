# frozen_string_literal: true

require "rails_helper"

describe "User menu", type: :system do
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

  context "when the user clicks the ephemeral participation button and toggles the user menu" do
    let(:current_user)     { Decidim::User.last }
    let(:session_duration) { 5.minutes }
    let(:toggle_user_menu) do
      within(".topbar__user__logged") do
        click_link(current_user.name)
      end
    end

    before do
      stub_const("#{Decidim::EphemeralParticipation::SessionPresenter}::EPHEMERAL_PARTICIPANT_SESSION_DURATION", session_duration)
      click_ephemeral_participation_button
      toggle_user_menu
    end

    it "shows alternative user menu" do
      within(".topbar__user__logged") do
        expect(page).to have_content("#{(session_duration / 1.minute).round} min. before automatic sign out")
        expect(page).to have_link("Finish your registration")
        expect(page).to have_link("Cancel and sign out")
      end
    end

    context "when the user clicks the sign out link" do
      before do
        within(".topbar__user__logged") do
          click_link("Cancel and sign out")
        end
      end

      it "closes the session and redirects to root_path" do
        within_flash_messages do
          expect(page).to have_content("en.decidim.ephemeral_participation.ephemeral_participants.destroy")
        end

        expect(page).to have_current_path(decidim.root_path)
      end
    end

    context "when the user clicks the complete registration link" do
      before do
        within(".topbar__user__logged") do
          click_link("Finish your registration")
        end
      end

      it "is shown the complete registration form" do
        expect(page).to have_content("Complete your profile for easily future participation")

        expect(page).to have_field("ephemeral_participant_name")
        expect(page).to have_field("ephemeral_participant_nickname")
        expect(page).to have_field("ephemeral_participant_email")
        expect(page).to have_field("ephemeral_participant_password")
        expect(page).to have_field("ephemeral_participant_password_confirmation")

        expect(page).to have_current_path(%r{#{decidim_ephemeral_participation.edit_ephemeral_participant_path(current_user)}.*})

        # flash message
        expect(page).not_to have_content("You need to be verified in order tor participate:")
        expect(page).not_to have_link("Complete the verification process here")
      end
    end
  end
end
