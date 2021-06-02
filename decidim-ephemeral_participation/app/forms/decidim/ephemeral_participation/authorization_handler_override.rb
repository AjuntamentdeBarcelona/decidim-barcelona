# frozen_string_literal: true

module Decidim
  module EphemeralParticipation
    module AuthorizationHandlerOverride
      extend ActiveSupport::Concern

      included do
        alias :old_uniqueness :uniqueness

        private

        def uniqueness
          return true if unique_id.nil? || duplicates.none?

          errors.add(:base, uniqueness_error)

          false
        end

        def uniqueness_error
          if user.ephemeral_participant?
            I18n.t(
              "decidim.authorization_handlers.errors.unverifiable_ephemeral_participant",
              href: Decidim::EphemeralParticipation::Engine.routes.url_helpers.unverifiable_ephemeral_participant_path(user),
            ).html_safe
          else
            I18n.t("decidim.authorization_handlers.errors.duplicate_authorization")
          end
        end
      end
    end
  end
end
