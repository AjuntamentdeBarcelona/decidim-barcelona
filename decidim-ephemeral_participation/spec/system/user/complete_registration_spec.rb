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
    let(:toggle_user_menu) do
      within(".topbar__user__logged") do
        click_link(current_user.name)
      end
    end
    let(:current_user) { Decidim::User.last }

    before do
      click_ephemeral_participation_button
      toggle_user_menu
    end

    context "when the user clicks the complete registration link" do
      before do
        within(".topbar__user__logged") do
          click_link("Finish your registration")
        end
      end

      context "when user submits complete registration form" do
        let(:submit_complete_registration_form) do
          within("form.edit_ephemeral_participant") do
            fill_in("ephemeral_participant_name", with: name)
            fill_in("ephemeral_participant_nickname", with: nickname)
            fill_in("ephemeral_participant_email", with: email)
            fill_in("ephemeral_participant_password", with: password)
            fill_in("ephemeral_participant_password_confirmation", with: password)
            find("*[type=submit]").click
          end
        end
        let(:name) { "New name" }
        let(:nickname) { "new_nickname" }
        let(:email) { "new@email.example" }
        let(:password) { "decidim123456" }

        before do
          submit_complete_registration_form
        end

        it "updates the user and redirects to account page" do
          within_flash_messages do
            expect(page).to have_content("en.decidim.ephemeral_participation.ephemeral_participants.update.success")
          end

          current_user.reload

          expect(current_user.name).to eq(name)
          expect(current_user.nickname).to eq(nickname)
          expect(current_user.email).to eq(email)
          expect(current_user.valid_password?(password)).to eq(true)
          expect(current_user.ephemeral_participant?).to eq(false)
          expect(current_user.confirmed?).to eq(true)

          expect(page).to have_current_path(%r{#{decidim.account_path}.*})
        end
      end
    end
  end
end
