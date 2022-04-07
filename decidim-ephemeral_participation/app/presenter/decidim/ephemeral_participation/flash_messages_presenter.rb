# frozen_string_literal: true

module Decidim
  module EphemeralParticipation
    class FlashMessagesPresenter
      include Decidim::EphemeralParticipation::EphemeralParticipationPathsHelper

      def initialize(user, view_helpers)
        @user = user
        @view_helpers = view_helpers
      end

      def unauthorized_ephemeral_participant_message
        I18n.t(
          "decidim.ephemeral_participation.actions.unauthorized",
          link:
            @view_helpers.link_to(
              I18n.t("decidim.ephemeral_participation.actions.unauthorized_link"),
              edit_ephemeral_participant_path(current_user)
            )
        ).html_safe
      end

      def verified_ephemeral_participant_message
        I18n.t(
          "decidim.ephemeral_participation.actions.verified",
          link: @view_helpers.link_to(
            I18n.t("decidim.ephemeral_participation.actions.verified_link"),
            edit_ephemeral_participant_path(current_user)
          )
        ).html_safe
      end

      def unverified_ephemeral_participant_message
        I18n.t(
          "decidim.ephemeral_participation.actions.unverified",
          link: @view_helpers.link_to(
            I18n.t("decidim.ephemeral_participation.actions.unverified_link"),
            verify_ephemeral_participant_path
          )
        ).html_safe
      end

      private

      def current_user
        @user
      end
    end
  end
end
