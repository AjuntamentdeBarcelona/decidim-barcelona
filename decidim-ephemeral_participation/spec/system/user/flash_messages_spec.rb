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
    let(:current_user)    { Decidim::User.last }
    let(:authorized_user) { current_user }

    before do
      click_ephemeral_participation_button
    end

    context "when the authorization is direct" do
      let(:ephemeral_participable_authorization) { "dummy_authorization_handler" }

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

        it "redirects to authorization form when following the message link" do
          within_flash_messages do
            click_link("Complete the verification process here")
          end

          expect(page).to have_current_path(%r{#{decidim_verifications.new_authorization_path}\?handler=#{ephemeral_participable_authorization}.*})

          expect(page).not_to have_content("You need to be verified in order tor participate:")
          expect(page).not_to have_link("Complete the verification process here")
        end
      end

      context "when the user visits another page AFTER submitting the authorization form" do
        before do
          submit_authorization_form
          visit(decidim.root_path)
        end

        it "invites user to complete their registration" do
          within_flash_messages do
            expect(page).to have_content("Finish your registration")
            expect(page).to have_link("here")
          end
        end

        it "redirects to complete registration form when following the message link" do
          within_flash_messages do
            click_link("here")
          end

          expect(page).to have_current_path(%r{#{decidim_ephemeral_participation.edit_ephemeral_participant_path(current_user)}.*})

          expect(page).not_to have_content("Finish your registration")
          expect(page).not_to have_link("here")
        end
      end
    end

    context "when the authorization has multiple steps" do
      let(:ephemeral_participable_authorization) { "id_documents" }

      context "when the user visits another page WITHOUT a pending authorization" do
        before do
          visit(decidim.root_path)
        end

        it "invites user to verify themselves" do
          within_flash_messages do
            expect(page).to have_content("You need to be verified in order tor participate:")
            expect(page).to have_link("Complete the verification process here")
          end
        end

        it "redirects to new authorization path when following the message link" do
          within_flash_messages do
            click_link("Complete the verification process here")
          end

          expect(page).to have_current_path(%r{#{decidim_id_documents.new_authorization_path}.*})

          expect(page).not_to have_content("You need to be verified in order tor participate:")
          expect(page).not_to have_link("Complete the verification process here")
        end
      end

      context "when the user visits another page WITH a pending authorization" do
        let(:pending_authorization) do
          create(
            :authorization,
            :pending,
            name: ephemeral_participable_authorization,
            user: current_user,
          )
        end

        before do
          pending_authorization
          visit(decidim.root_path)
        end

        it "invites user to verify themselves" do
          within_flash_messages do
            expect(page).to have_content("You need to be verified in order tor participate:")
            expect(page).to have_link("Complete the verification process here")
          end
        end

        it "redirects to resume authorization path when following the message link" do
          within_flash_messages do
            click_link("Complete the verification process here")
          end

          expect(page).to have_current_path(%r{#{decidim_id_documents.edit_authorization_path}.*})

          expect(page).not_to have_content("You need to be verified in order tor participate:")
          expect(page).not_to have_link("Complete the verification process here")
        end
      end

      context "when the user visits another page WITH a granted authorization" do

        before do
          authorization
          visit(decidim.root_path)
        end

        it "invites user to complete their registration" do
          within_flash_messages do
            expect(page).to have_content("Finish your registration")
            expect(page).to have_link("here")
          end
        end

        it "redirects to complete registration form when following the message link" do
          within_flash_messages do
            click_link("here")
          end

          expect(page).to have_current_path(%r{#{decidim_ephemeral_participation.edit_ephemeral_participant_path(current_user)}.*})

          expect(page).not_to have_content("Finish your registration")
          expect(page).not_to have_link("here")
        end
      end
    end
  end
end
