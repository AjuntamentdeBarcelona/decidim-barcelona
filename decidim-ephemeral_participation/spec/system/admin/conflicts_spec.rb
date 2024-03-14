# frozen_string_literal: true

require "rails_helper"

describe "Conflicts" do
  include_context "when managing a component with ephemerable participation"

  let!(:conflict) { Decidim::Verifications::Conflict.create(current_user: ephemeral_participant, managed_user: authorized_user) }
  let(:manifest_name) { "budgets" }
  let(:ephemeral_participable_authorization) { "dummy_authorization_handler" }
  let(:ephemeral_participable_action) { "vote" }
  let(:ephemeral_participation_path) { "/some/path" }

  before do
    authorization
    register_workflows
    switch_to_host(organization.host)
  end

  context "when an admin authenticated" do
    before do
      login_as(user, scope: :user)
    end

    shared_examples "fails to transfer the users" do
      it "fails to transfer the users" do
        within(".callout") do
          expect(page).to have_content("There was a problem transfering the current participant to managed participant.")
        end

        previous_email = authorized_user.email

        expect(authorized_user.reload.email).to eq(previous_email)
        expect(ephemeral_participant.reload.deleted?).to be false
        expect(conflict.reload.solved?).to be false
      end
    end

    context "when managing participants verification conflicts from ephemeral participants" do
      before do
        visit(decidim_admin.conflicts_path)
      end

      context "when conflict is with a regular user" do
        let(:authorized_user) { regular_user }

        context "when transfering the user" do
          before do
            click_on(href: "/admin/conflicts/#{conflict.id}/edit")
          end

          context "and submitting a registered email" do
            let(:email) { authorized_user.email }

            before do
              fill_in("Email", with: email)
              click_on("Transfer")
            end

            include_examples "fails to transfer the users"
          end

          context "and submitting a NON registered email" do
            let(:email) { "unique@email.example" }

            before do
              fill_in("Email", with: email)
              click_on("Transfer")
            end

            include_examples "fails to transfer the users"
          end
        end
      end

      context "when conflict is with another ephemeral participant" do
        let(:authorized_user) { create_ephemeral_participant }

        context "when transfering the user" do
          before do
            click_on(href: "/admin/conflicts/#{conflict.id}/edit")
          end

          context "and submitting a registered email" do
            let(:email) { authorized_user.email }

            before do
              fill_in("Email", with: email)
              click_on("Transfer")
            end

            include_examples "fails to transfer the users"
          end

          context "and submitting a NON registered email" do
            let(:email) { "unique@email.example" }

            before do
              fill_in("Email", with: email)
              click_on("Transfer")
            end

            it "transfers the users successfuly" do
              within(".callout") do
                expect(page).to have_content("The current transfer has been successfully completed.")
              end

              expect(authorized_user.reload.email).to eq(email)
              expect(ephemeral_participant.reload.deleted?).to be true
              expect(conflict.reload.solved?).to be true
            end
          end
        end
      end
    end
  end
end
