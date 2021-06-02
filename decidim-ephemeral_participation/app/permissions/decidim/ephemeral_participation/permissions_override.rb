# frozen_string_literal: true

module Decidim
  module EphemeralParticipation
    module PermissionsOverride
      extend ActiveSupport::Concern

      included do
        alias :old_permissions :permissions

        def permissions
          old_permissions
          new_permissions
        end

        private

        def new_permissions
          Decidim::EphemeralParticipation::EphemeralParticipationPermissions.new(user, permission_action, context).permissions
        end
      end
    end
  end
end
