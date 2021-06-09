# frozen_string_literal: true

require "rails_helper"

describe "Flash messages", type: :system do
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
    let(:current_user) { Decidim::User.last }

    before do
      click_ephemeral_participation_button
    end

    context "when the user visits another page WITHOUT submitting the authorization form" do
      before do
        visit(decidim.root_path)
      end

      it "invites user to verify themselves" do
        within_flash_messages do
          expect(page).to have_content("You need to be verified in order tor participate:")
          expect(page).to have_link("Complete the verification process here")
        end
      end
    end

    context "when the user visits another page AFTER submitting the authorization form" do
      before do
        submit_authorization_form
        visit(decidim.root_path)
      end

      it "invites user to verify themselves" do
        within_flash_messages do
          expect(page).to have_content("Finish your registration")
          expect(page).to have_link("here")
        end
      end
    end
  end
end
