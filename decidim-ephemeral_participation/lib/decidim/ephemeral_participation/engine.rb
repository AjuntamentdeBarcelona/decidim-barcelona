# frozen_string_literal: true

module Decidim
  module EphemeralParticipation
    class Engine < ::Rails::Engine
      isolate_namespace Decidim::EphemeralParticipation

      config.to_prepare do
        # cells
        Decidim::Budgets::ProjectListItemCell.include(Decidim::EphemeralParticipation::ProjectListItemCellOverride)
        # commands
        Decidim::Admin::TransferUser.include(Decidim::EphemeralParticipation::TransferUserOverride)
        Decidim::Verifications::PerformAuthorizationStep.include(Decidim::EphemeralParticipation::PerformAuthorizationStepOverride)
        # controllers
        Decidim::ApplicationController.include(Decidim::EphemeralParticipation::ApplicationControllerOverride)
        Decidim::Admin::ConflictsController.include(Decidim::EphemeralParticipation::ConflictsControllerOverride)
        # forms
        Decidim::AuthorizationHandler.include(Decidim::EphemeralParticipation::AuthorizationHandlerOverride)
        Decidim::Admin::ComponentForm.include(Decidim::EphemeralParticipation::ComponentFormOverride)
        Decidim::Admin::PermissionsForm.include(Decidim::EphemeralParticipation::PermissionsFormOverride)
        Decidim::System::UpdateOrganizationForm.include(Decidim::EphemeralParticipation::UpdateOrganizationFormOverride)
        # models
        Decidim::Component.include(Decidim::EphemeralParticipation::ComponentOverride)
        Decidim::Organization.include(Decidim::EphemeralParticipation::OrganizationOverride)
        Decidim::PermissionAction.include(Decidim::EphemeralParticipation::PermissionActionOverride)
        Decidim::User.include(Decidim::EphemeralParticipation::UserOverride)
        # permissions
        Decidim::Permissions.include(Decidim::EphemeralParticipation::PermissionsOverride)
      end

      initializer "ephemeral_participation.component_override" do
        Decidim.component_registry.find(:budgets).tap do |component|
          component.settings(:global) do |settings|
            settings.attribute(:ephemeral_participation_enabled, type: :boolean, default: false)
            settings.attribute(:ephemeral_participation_enabled_confirm_modal, type: :text, translated: true, editor: true)
          end
        end
      end

      routes do
        scope :ephemeral_participation do
          resources :ephemeral_participants, only: [:create, :edit, :update, :destroy] do
            member do
              get :unverifiable, controller: :ephemeral_participants, action: :edit_unverifiable
              put :unverifiable, controller: :ephemeral_participants, action: :update_unverifiable
            end
          end
        end
      end
    end
  end
end
