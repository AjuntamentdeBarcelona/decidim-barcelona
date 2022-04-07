# frozen_string_literal: true

require "rails_helper"

describe "Verification conflicts", type: :system do
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

  context "when an authorization already exists with the same data" do
    let(:authorized_user) { regular_user }

    before do
      authorization
    end

    context "when the user tries to verify themselves" do
      let(:ephemeral_participation_path) { page.current_path }

      before do
        ephemeral_participation_path
        click_ephemeral_participation_button
        submit_authorization_form
      end

      it "creates verification conflict and notifies admins" do
        expect(Decidim::Verifications::Conflict.count).to eq(1)

        notification_job = {
          job: Decidim::EventPublisherJob,
          args: array_including("decidim.events.verifications.managed_user_error_event"),
          queue: "events"
        }

        expect(enqueued_jobs.last).to match(notification_job)
      end

      it "shows an error" do
        # flash message
        expect(page).to have_content("There was a problem creating the authorization.")
        # error message
        expect(page).to have_content("en.decidim.authorization_handlers.errors.already_exists")
        expect(page).to have_content("en.decidim.authorization_handlers.errors.already_participate")
        expect(page).to have_link("en.decidim.authorization_handlers.errors.retrieve_user")
        expect(page).to have_link("en.decidim.authorization_handlers.errors.close")
      end

      context "when the user clicks the close link" do
        before do
          click_link("en.decidim.authorization_handlers.errors.close")
        end

        it "closes the session and redirects back to where ephemeral participation button was clicked" do
          within_flash_messages do
            expect(page).to have_content("en.decidim.ephemeral_participation.ephemeral_participants.destroy")
          end

          expect(page).to have_current_path(ephemeral_participation_path)
        end
      end

      context "when the user visits any other page" do
        before do
          visit decidim.root_path
        end

        it "redirects to the unverifiable form" do
          expect(page).to have_current_path(%r{/ephemeral_participation/ephemeral_participants/\d+/unverifiable})
        end
      end

      context "when the user clicks the retrieve_user link" do
        before do
          click_link("en.decidim.authorization_handlers.errors.retrieve_user")
        end

        it "shows the unverifiable form" do
          expect(page).to have_content("en.decidim.ephemeral_participation.ephemeral_participants.unverifiable.title")
          expect(page).to have_content("en.decidim.ephemeral_participation.ephemeral_participants.unverifiable.help")
          expect(page).to have_link("en.decidim.ephemeral_participation.ephemeral_participants.unverifiable.reset_password")
          expect(page).to have_link("en.decidim.authorization_handlers.errors.close")
          expect(page).to have_field("unverifiable_ephemeral_participant_email")

          expect(page).to have_current_path(%r{/ephemeral_participation/ephemeral_participants/\d+/unverifiable})

          # flash message
          expect(page).not_to have_content("You need to be verified in order tor participate:")
          expect(page).not_to have_link("Complete the verification process here")
        end

        context "when the user submits the unverifiable form" do
          let(:unverifiable_ephemeral_participant) { Decidim::User.last }

          before do
            submit_unverifiable_form
          end

          context "and the conflict is with an ephemeral participant" do
            let(:authorized_user) { ephemeral_participant }

            context "and the email is already registered" do
              let(:email) { regular_user.email }

              it "closes the session and redirects to root_path" do
                within_flash_messages do
                  expect(page).to have_content("en.decidim.ephemeral_participation.ephemeral_participants.update_unverifiable.error.email_taken")
                end

                expect(page).to have_current_path(decidim.root_path)
              end

              it "does NOT update the verified ephemeral participant" do
                ephemeral_participant.reload

                expect(ephemeral_participant.email).to eq("")
                expect(ephemeral_participant.ephemeral_participant?).to eq(true)
                expect(ephemeral_participant.confirmed?).to eq(false)
              end

              it "does NOT delete the unverifiable ephemeral participant" do
                expect(unverifiable_ephemeral_participant.deleted?).to eq(false)
              end

              it "does NOT send reset password instructions email" do
                expect(ActionMailer::Base.deliveries.count).to eq(0)
              end
            end

            context "and the email is NOT registered" do
              let(:email) { "unique@email.example" }

              it "closes the session and redirects to root_path" do
                within_flash_messages do
                  expect(page).to have_content("en.decidim.ephemeral_participation.ephemeral_participants.update_unverifiable.success")
                end

                expect(page).to have_current_path(decidim.root_path)
              end

              it "updates the verified ephemeral participant" do
                ephemeral_participant.reload

                expect(ephemeral_participant.email).to eq(email)
                expect(ephemeral_participant.ephemeral_participant?).to eq(false)
                expect(ephemeral_participant.confirmed?).to eq(true)
              end

              it "deletes the unverifiable ephemeral participant" do
                expect(unverifiable_ephemeral_participant.deleted?).to eq(true)
              end

              it "sends reset password instructions email" do
                reset_password_instructions = ActionMailer::Base.deliveries.last

                expect(reset_password_instructions.to).to eq([email])
                expect(reset_password_instructions.body.encoded).to include(decidim.edit_user_password_path)
              end

              # rubocop:disable RSpec/NestedGroups:
              context "when following instructions email link and updating the password" do
                let(:submit_password_form) do
                  within("form#password_new_user") do
                    fill_in(:password_user_password, with: "decidim123456")
                    fill_in(:password_user_password_confirmation, with: "decidim123456")
                    find("*[type=submit]").click
                  end
                end
                let(:reset_password_token) do
                  text = ActionMailer::Base.deliveries.last.text_part.decoded
                  regex = %r{.*http://localhost/users/password/edit\?reset_password_token=}
                  match = text.match(regex)

                  match.post_match.split.first
                end

                before do
                  visit(decidim.edit_user_password_path(reset_password_token: reset_password_token))
                  submit_password_form
                end

                it "logs the user and redirects to account page" do
                  within_flash_messages do
                    expect(page).to have_content("Your password has been successfully changed. You are now signed in.")
                  end

                  expect(page).to have_current_path(/#{decidim.account_path}.*/)
                end
              end
              # rubocop:enable RSpec/NestedGroups:
            end
          end

          context "and the conflict is with a regular participant" do
            let(:authorized_user) { regular_user }

            context "and the email is already registered" do
              let(:email) { regular_user.email }

              it "closes the session and redirects to root_path" do
                within_flash_messages do
                  expect(page).to have_content("en.decidim.ephemeral_participation.ephemeral_participants.update_unverifiable.error.email_taken")
                end

                expect(page).to have_current_path(decidim.root_path)
              end

              it "does NOT update the verified ephemeral participant" do
                ephemeral_participant.reload

                expect(ephemeral_participant.email).to eq("")
                expect(ephemeral_participant.ephemeral_participant?).to eq(true)
                expect(ephemeral_participant.confirmed?).to eq(false)
              end

              it "does NOT delete the unverifiable ephemeral participant" do
                expect(unverifiable_ephemeral_participant.deleted?).to eq(false)
              end

              it "does NOT send reset password instructions email" do
                expect(ActionMailer::Base.deliveries.count).to eq(0)
              end
            end

            context "and the email is NOT registered" do
              let(:email) { "unique@email.example" }

              it "closes the session and redirects to root_path" do
                within_flash_messages do
                  expect(page).to have_content("en.decidim.ephemeral_participation.ephemeral_participants.update_unverifiable.error.admin_contact")
                end

                expect(page).to have_current_path(decidim.root_path)
              end

              it "does NOT update the verified ephemeral participant" do
                ephemeral_participant.reload

                expect(ephemeral_participant.email).to eq("")
                expect(ephemeral_participant.ephemeral_participant?).to eq(true)
                expect(ephemeral_participant.confirmed?).to eq(false)
              end

              it "does NOT delete the unverifiable ephemeral participant" do
                expect(unverifiable_ephemeral_participant.deleted?).to eq(false)
              end

              it "does NOT send reset password instructions email" do
                expect(ActionMailer::Base.deliveries.count).to eq(0)
              end
            end
          end
        end

        context "when the user clicks the close link" do
          before do
            click_link("en.decidim.authorization_handlers.errors.close")
          end

          it "closes the session and redirects back to where ephemeral participation button was clicked" do
            within_flash_messages do
              expect(page).to have_content("en.decidim.ephemeral_participation.ephemeral_participants.destroy")
            end

            expect(page).to have_current_path(ephemeral_participation_path)
          end
        end

        context "when the user clicks the reset_password link" do
          before do
            click_link("en.decidim.ephemeral_participation.ephemeral_participants.unverifiable.reset_password")
          end

          it "closes the session and redirects to the reset password form" do
            within_flash_messages do
              expect(page).to have_content("en.decidim.ephemeral_participation.ephemeral_participants.destroy")
            end

            expect(page).to have_current_path(/#{decidim.new_user_password_path}.*/)
          end
        end
      end
    end
  end
end
