# frozen_string_literal: true

module Decidim
  module EphemeralParticipation
    class EphemeralActionPermissionsDictionary
      COMPONENT_PERMISSIONS_DICTIONARY = {
        "budgets" => {
          "vote" => [
            { action: :vote,   scope: :public, subject: :project },
            { action: :create, scope: :public, subject: :order },
          ]
        }
      }

      def self.for(component)
        new(component).fetch
      end

      def initialize(component)
        @component = component
      end

      def fetch
        return {} unless @component && @component.ephemeral_participation_permissions.any?

        COMPONENT_PERMISSIONS_DICTIONARY.fetch(@component.manifest_name).select do |action, _|
          @component.ephemeral_participation_permissions.include?(action)
        end
      end
    end
  end
end
