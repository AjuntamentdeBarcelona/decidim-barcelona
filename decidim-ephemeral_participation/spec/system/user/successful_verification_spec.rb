# frozen_string_literal: true

require "rails_helper"

describe "Succesful verification", type: :system do
  include_context "with ephemerable participation"

  let!(:project) { create(:project, budget: budget) }
  let(:budget) { create(:budget, component: component) }
  let(:manifest_name) { "budgets" }
  let(:ephemeral_participable_authorization) { "dummy_authorization_handler" }
  let(:ephemeral_participable_action) { "vote" }
  let(:ephemeral_participation_button_selector) { "#project-vote-button-#{project.id}" }

  before do
    register_workflows
    switch_to_host(organization.host)
    visit_component
  end

  context "when the user clicks the ephemeral participation button and submits the authorization form" do
    let(:ephemeral_participation_path) { page.current_path }

    before do
      ephemeral_participation_path
      click_ephemeral_participation_button
      submit_authorization_form
    end

    it "authorizes the user and redirects back to where ephemeral participation button was clicked" do
      within_flash_messages do
        expect(page).to have_content("You've been successfully authorized")
      end

      expect(page).to have_current_path(ephemeral_participation_path)
    end
  end
end
