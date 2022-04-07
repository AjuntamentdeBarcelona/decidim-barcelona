# frozen_string_literal: true

module Decidim
  module EphemeralParticipation
    module PermissionsFormOverride
      extend ActiveSupport::Concern

      included do
        attribute :component_id, String
        attribute :resource_id, String

        validate :validate_ephemeral_participation_permissions_settings

        private

        def validate_ephemeral_participation_permissions_settings
          return if resource_permissions?
          return unless ephemeral_participation_enabled?

          permissions.values.each do |permission_form|
            next if valid_permission_form?(permission_form)

            permission_form.errors.add(:base, :invalid_ephemeral_participation_permissions, i18n_options)
          end
        end

        def resource_permissions?
          resource_id.present?
        end

        def ephemeral_participation_enabled?
          component.ephemeral_participation_enabled?
        end

        def valid_permission_form?(permission_form)
          handler_names = permission_form.authorization_handlers.keys & component.organization.available_authorizations

          handler_names.exclude?(component.organization.ephemeral_participation_authorization) || handler_names.size == 1
        end

        def component
          @component ||= Decidim::Component.find(component_id)
        end

        def i18n_options
          {
            ephemeral_participation_authorization: I18n.t("decidim.authorization_handlers.#{component.organization.ephemeral_participation_authorization}.name"),
            ephemeral_participation_enabled: I18n.t("decidim.components.#{component.manifest_name}.settings.global.ephemeral_participation_enabled")
          }
        end
      end
    end
  end
end
