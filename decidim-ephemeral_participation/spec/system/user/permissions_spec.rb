# frozen_string_literal: true

require "rails_helper"

describe "Permissions", type: :system do
  include_context "with ephemerable participation"

  let(:budget) { create(:budget, component: component, total_budget: 50_000_000) }
  let!(:project) { create(:project, budget: budget, budget_amount: 25_000_000) }
  let(:manifest_name) { "budgets" }
  let(:settings) do
    {
      vote_threshold_percent: 50,
      ephemeral_participation_enabled: true,
      ephemeral_participation_enabled_confirm_modal: { "en"=>"<p>Are you sure?</p>" }
    }
  end
  let(:ephemeral_participable_authorization) { "dummy_authorization_handler" }
  let(:ephemeral_participable_action) { "vote" }
  let(:ephemeral_participation_action_button_selector) { "#project-vote-button-#{project.id}" }

  before do
    register_workflows
    switch_to_host(organization.host)
    visit_component
  end

  context "when the user clicks the ephemeral participation button" do
    let(:ephemeral_participation_path) { page.current_path }
    let(:current_user) { Decidim::User.last }

    before do
      ephemeral_participation_path
      click_ephemeral_participation_button
    end

    def perform_non_authorized_action
      click_link(project.title["en"])

      within("form.new_comment") do
        fill_in("Comment", with: "New comment")
        find("*[type=submit]").click
      end
    end

    context "when the user performs an authorized action WITHOUT submitting the authorization form" do
      let(:perform_authorized_action_supposed_to_redirect) do
        click_link(project.title["en"])

        within("#project") do
          click_link("Add to your vote")
        end
      end

      before do
        visit_component
        perform_authorized_action_supposed_to_redirect
      end

      it "redirects to the authorization form" do
        expect(page).to have_current_path(%r{#{decidim_verifications.new_authorization_path}\?handler=#{ephemeral_participable_authorization}.*})
      end
    end

    context "when the user performs a non authorized action WITHOUT submitting the authorization form" do
      before do
        visit_component
        perform_non_authorized_action
      end

      it "disallows to perfom non authorized action" do
        within_flash_messages do
          expect(page).to have_content("You need to be verified in order tor participate")
          expect(page).to have_link("Complete the verification process here.")
        end
      end
    end

    context "when the user submits the authorization form" do
      before do
        submit_authorization_form
      end

      it "allows to perfom authorized action" do
        click_ephemeral_parcipation_action_button

        click_button("Vote")
        click_button("Confirm")

        expect(page).to have_content("You've already voted for the budget.")
      end

      it "disallows to perfom non authorized action" do
        perform_non_authorized_action

        within_flash_messages do
          expect(page).to have_content("You are not authorized to perform this action")
          expect(page).to have_link("Finish your registration here")
        end
      end

      it "redirects to complete registration form when visiting user account related pages" do
        [
          decidim.account_path,
          decidim.notifications_settings_path,
          decidim.data_portability_path,
          decidim.own_user_groups_path,
          decidim.user_interests_path,
          decidim.notifications_path,
          decidim.conversations_path,
          decidim.profile_path(current_user.nickname),
        ].each do |user_account_related_path|
          visit(user_account_related_path)

          expect(page).to have_current_path(%r{#{decidim_ephemeral_participation.edit_ephemeral_participant_path(current_user)}.*})
        end
      end

      it "redirects back to where ephemeral participation button was clicked when visiting authorizations path" do
        visit(decidim_verifications.authorizations_path)

        expect(page).to have_current_path(%r{#{ephemeral_participation_path}.*})
      end
    end
  end
end
