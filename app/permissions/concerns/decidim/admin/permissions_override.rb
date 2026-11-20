# frozen_string_literal: true

module Decidim
  module Admin
    # Backport of https://github.com/decidim/decidim/pull/18138
    #
    # Since 0.30 only organization admins can soft delete, restore and manage the
    # trash of resources. This grants the same trash actions to the admins of the
    # participatory space that owns the current component.
    #
    # Remove once the upstream fix is released and decidim is upgraded.
    module PermissionsOverride
      extend ActiveSupport::Concern

      def permissions
        super

        apply_trash_permissions! if permission_action.scope == :admin && user && space_admin_trash_action?

        permission_action
      end

      private

      def trash_action?
        permission_action.action.in?([:manage_trash, :restore, :soft_delete])
      end

      def apply_trash_permissions!
        case permission_action.action
        when :soft_delete
          toggle_allow(trashable_deleted_resource.respond_to?(:deleted?) && !trashable_deleted_resource.deleted?)
        when :restore
          toggle_allow(trashable_deleted_resource&.deleted?)
        else
          allow!
        end
      end

      def space_admin_trash_action?
        return false unless trash_action?
        return false if user.admin?
        return false unless admin_terms_accepted?
        return false unless current_component && current_participatory_space
        return false unless current_component.participatory_space == current_participatory_space
        return false if trashable_deleted_resource && trashable_deleted_resource.try(:component) != current_component

        user_can_manage_current_component?
      end

      def user_can_manage_current_component?
        manage_component_action = Decidim::PermissionAction.new(scope: :admin, action: :manage, subject: :component)

        current_participatory_space.manifest.permissions_class.new(user, manage_component_action, context).permissions.allowed?
      rescue Decidim::PermissionAction::PermissionNotSetError
        false
      end

      def current_component
        context.fetch(:current_component, nil)
      end

      def current_participatory_space
        context.fetch(:current_participatory_space, nil)
      end
    end
  end
end
