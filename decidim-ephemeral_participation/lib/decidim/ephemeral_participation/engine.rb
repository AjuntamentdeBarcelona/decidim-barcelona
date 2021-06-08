# frozen_string_literal: true

module Decidim
  module EphemeralParticipation
    class Engine < ::Rails::Engine
      isolate_namespace Decidim::EphemeralParticipation

      config.to_prepare do
        # commands
        Decidim::Admin::TransferUser.include(Decidim::EphemeralParticipation::TransferUserOverride)
        # controllers
        Decidim::ApplicationController.include(Decidim::EphemeralParticipation::ApplicationControllerOverride)
        Decidim::Admin::ConflictsController.include(Decidim::EphemeralParticipation::ConflictsControllerOverride)
        # forms
        Decidim::Admin::ComponentForm.include(Decidim::EphemeralParticipation::ComponentFormOverride)
        Decidim::Admin::PermissionsForm.include(Decidim::EphemeralParticipation::PermissionsFormOverride)
        Decidim::Admin::TransferUserForm.include(Decidim::EphemeralParticipation::TransferUserFormOverride)
        Decidim::System::UpdateOrganizationForm.include(Decidim::EphemeralParticipation::UpdateOrganizationFormOverride)
        # models
        Decidim::Component.include(Decidim::EphemeralParticipation::ComponentOverride)
        Decidim::Organization.include(Decidim::EphemeralParticipation::OrganizationOverride)
        Decidim::PermissionAction.include(Decidim::EphemeralParticipation::PermissionActionOverride)
        Decidim::User.include(Decidim::EphemeralParticipation::UserOverride)
        # permissions
        Decidim::Permissions.include(Decidim::EphemeralParticipation::PermissionsOverride)
        # budgets states
        Decidim::Budgets::ProjectListItemCell.include(Decidim::EphemeralParticipation::ProjectListItemCellOverride)

      end

      initializer "ephemeral_participation.component_override" do
        Decidim.component_registry.find(:budgets).tap do |component|
          component.settings(:global) do |settings|
            settings.attribute(:ephemeral_participation_enabled, type: :boolean, default: false)
          end
        end
      end

      routes do
        scope :ephemeral_participation do
          resources :ephemeral_participants, only: [:create, :edit, :update, :destroy]
        end
      end
    end
  end
end
