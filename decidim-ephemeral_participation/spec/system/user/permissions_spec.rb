# frozen_string_literal: true

require "rails_helper"

describe "Permissions" do
  include_context "with ephemerable participation"

  let(:budget) { create(:budget, component:, total_budget: 50_000_000) }
  let!(:project) { create(:project, budget:, budget_amount: 25_000_000) }
  let(:manifest_name) { "budgets" }
  let(:settings) do
    {
      vote_threshold_percent: 50,
      ephemeral_participation_enabled: true,
      ephemeral_participation_enabled_confirm_modal: { "en" => "<p>Are you sure?</p>" }
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
      click_on(project.title["en"])

      within("form.new_comment") do
        fill_in("Comment", with: "New comment")
        find("*[type=submit]").click
      end
    end

    context "when the user performs an authorized action WITHOUT submitting the authorization form" do
      let(:perform_authorized_action_supposed_to_redirect) do
        click_on(project.title["en"])

        within("#project-item") do
          click_on("Add")
        end
      end

      before do
        visit_component
        perform_authorized_action_supposed_to_redirect
      end

      it "redirects to the authorization form" do
        expect(page).to have_current_path(/#{decidim_verifications.new_authorization_path}\?handler=#{ephemeral_participable_authorization}.*/)
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

      it "allows to perform authorized action" do
        click_ephemeral_participation_action_button

        click_on("Vote")
        click_on("Confirm")

        expect(page).to have_content("You have already voted for the budget.")
      end

      it "disallows to perform non authorized action" do
        perform_non_authorized_action

        within "#content" do
          within_flash_messages do
            expect(page).to have_content("You are not authorized to perform this action")
            expect(page).to have_link("Finish your registration here")
          end
        end
      end

      it "redirects to complete registration form when visiting user account related pages" do
        [
          decidim.account_path,
          decidim.notifications_settings_path,
          decidim.download_your_data_path,
          decidim.own_user_groups_path,
          decidim.user_interests_path,
          decidim.notifications_path,
          decidim.conversations_path,
          decidim.profile_path(current_user.nickname)
        ].each do |user_account_related_path|
          visit(user_account_related_path)

          expect(page).to have_current_path(/#{decidim_ephemeral_participation.edit_ephemeral_participant_path(current_user)}.*/)
        end
      end

      it "redirects back to where ephemeral participation button was clicked when visiting authorizations path" do
        visit(decidim_verifications.authorizations_path)

        expect(page).to have_current_path(/#{ephemeral_participation_path}.*/)
      end

      context "when there are public surveys" do
        let!(:surveys_component) do
          create(:component, manifest_name: :surveys, participatory_space:, step_settings:)
        end
        let(:step_settings) do
          {
            participatory_space.active_step.id => {
              allow_answers: true,
              allow_unregistered: true
            }
          }
        end
        let!(:questionnaire) { create(:questionnaire) }
        let!(:survey) { create(:survey, component: surveys_component, questionnaire:) }
        let!(:question) { create(:questionnaire_question, questionnaire:, position: 0) }

        it "allows answering the questionnaire" do
          visit main_component_path(surveys_component)

          expect(page).to have_i18n_content(questionnaire.title)
          expect(page).to have_i18n_content(questionnaire.description)

          fill_in(question.body["en"], with: "My first answer")

          check("questionnaire_tos_agreement")

          accept_confirm { click_on "Submit" }

          within_flash_messages do
            expect(page).to have_content("successfully")
          end

          expect(page).to have_content("You have already answered this form.")
        end
      end
    end
  end
end
