# frozen_string_literal: true

require "rails_helper"

describe "Component", type: :system do
  include_context "when managing a component's ephemerable permissions as an admin"

  let(:organization) do
    create(
      :organization,
      name: "Ajuntament",
      default_locale: :ca,
      available_locales: [:es, :ca],
      available_authorizations: authorizations
    )
  end

  let(:component) do
    create(:component, manifest_name: :budgets, participatory_space: participatory_space).tap do |component|
      component.settings = settings
      component.save!
    end
  end

  let(:settings) do
    {}
  end

  before do
    switch_to_host(organization.host)
  end

  context "when an admin authenticated" do
    before do
      login_as(user, scope: :user)
    end

    describe "editing component settings" do
      before do
        visit edit_component_path(component)
      end

      context "when organization has authorization enabled that allows ephemeral participation" do
        let(:authorizations) do
          { "dummy_authorization_handler" => { "allow_ephemeral_participation" => true } }
        end

        it "updates settings ephemeral_participation_enabled" do
          check("component_settings_ephemeral_participation_enabled")

          fill_in_i18n_editor(
            "component_settings_ephemeral_participation_enabled_confirm_modal",
            "#global-settings-ephemeral_participation_enabled_confirm_modal-tabs",
            ca: "Alerta!",
            es: "Alerta!",
          )

          find("*[type=submit]").click

          expect(page).to have_css("div.callout.success")
        end
      end

      context "when organization has no authorization enabled that allows ephemeral participation" do
        let(:authorizations) do
          { "dummy_authorization_handler" => { "allow_ephemeral_participation" => false } }
        end

        it "fails to update settings ephemeral_participation_enabled" do
          check("component_settings_ephemeral_participation_enabled")

          fill_in_i18n_editor(
            "component_settings_ephemeral_participation_enabled_confirm_modal",
            "#global-settings-ephemeral_participation_enabled_confirm_modal-tabs",
            ca: "Alerta!",
            es: "Alerta!",
          )

          find("*[type=submit]").click

          expect(page).to have_css("div.callout.alert")
        end
      end
    end

    describe "editing component permissions" do
      before do
        register_workflows
        visit edit_component_permissions_path(component)
      end

      context "when organization has authorization enabled that allows ephemeral participation" do
        let(:authorizations) do
          {
            "dummy_authorization_handler" => { "allow_ephemeral_participation" => true },
            "another_dummy_authorization_handler" => { "allow_ephemeral_participation" => false },
          }
        end

        context "and component has ephemeral_participation_enabled" do
          let(:settings) do
            { ephemeral_participation_enabled: true }
          end

          it "updates permissions when selecting ephemeral authorization for a given action" do
            check("component_permissions_permissions_vote_authorization_handlers_dummy_authorization_handler")

            find("*[type=submit]").click

            expect(page).to have_css("div.callout.success")
          end

          it "updates permissions when selecting regular authorization for a given action" do
            check("component_permissions_permissions_vote_authorization_handlers_another_dummy_authorization_handler")

            find("*[type=submit]").click

            expect(page).to have_css("div.callout.success")
          end

          it "fails to update permissions when selecting more than one authorization for a given action" do
            check("component_permissions_permissions_vote_authorization_handlers_dummy_authorization_handler")
            check("component_permissions_permissions_vote_authorization_handlers_another_dummy_authorization_handler")

            find("*[type=submit]").click

            expect(page).to have_css("div.callout.alert")
          end
        end

        context "and component does not have ephemeral_participation_enabled" do
          let(:settings) do
            { ephemeral_participation_enabled: false }
          end

          it "updates permissions when selecting ephemeral authorization for a given action" do
            check("component_permissions_permissions_vote_authorization_handlers_dummy_authorization_handler")

            find("*[type=submit]").click

            expect(page).to have_css("div.callout.success")
          end

          it "updates permissions when selecting regular authorization for a given action" do
            check("component_permissions_permissions_vote_authorization_handlers_another_dummy_authorization_handler")

            find("*[type=submit]").click

            expect(page).to have_css("div.callout.success")
          end

          it "updates permissions when selecting more than one authorization for a given action" do
            check("component_permissions_permissions_vote_authorization_handlers_dummy_authorization_handler")
            check("component_permissions_permissions_vote_authorization_handlers_another_dummy_authorization_handler")

            find("*[type=submit]").click

            expect(page).to have_css("div.callout.success")
          end
        end
      end

      context "when organization has no authorization enabled that allows ephemeral participation" do
        let(:authorizations) do
          {
            "dummy_authorization_handler" => { "allow_ephemeral_participation" => false },
            "another_dummy_authorization_handler" => { "allow_ephemeral_participation" => false },
          }
        end

        context "and component has ephemeral_participation_enabled" do
          let(:settings) do
            { ephemeral_participation_enabled: true }
          end

          it "updates permissions when selecting ephemeral authorization for a given action" do
            check("component_permissions_permissions_vote_authorization_handlers_dummy_authorization_handler")

            find("*[type=submit]").click

            expect(page).to have_css("div.callout.success")
          end

          it "updates permissions when selecting regular authorization for a given action" do
            check("component_permissions_permissions_vote_authorization_handlers_another_dummy_authorization_handler")

            find("*[type=submit]").click

            expect(page).to have_css("div.callout.success")
          end

          it "updates permissions when selecting more than one authorization for a given action" do
            check("component_permissions_permissions_vote_authorization_handlers_dummy_authorization_handler")
            check("component_permissions_permissions_vote_authorization_handlers_another_dummy_authorization_handler")

            find("*[type=submit]").click

            expect(page).to have_css("div.callout.success")
          end
        end

        context "and component does not have ephemeral_participation_enabled" do
          let(:settings) do
            { ephemeral_participation_enabled: false }
          end

          it "updates permissions when selecting ephemeral authorization for a given action" do
            check("component_permissions_permissions_vote_authorization_handlers_dummy_authorization_handler")

            find("*[type=submit]").click

            expect(page).to have_css("div.callout.success")
          end

          it "updates permissions when selecting regular authorization for a given action" do
            check("component_permissions_permissions_vote_authorization_handlers_another_dummy_authorization_handler")

            find("*[type=submit]").click

            expect(page).to have_css("div.callout.success")
          end

          it "updates permissions when selecting more than one authorization for a given action" do
            check("component_permissions_permissions_vote_authorization_handlers_dummy_authorization_handler")
            check("component_permissions_permissions_vote_authorization_handlers_another_dummy_authorization_handler")

            find("*[type=submit]").click

            expect(page).to have_css("div.callout.success")
          end
        end
      end
    end
  end
end
