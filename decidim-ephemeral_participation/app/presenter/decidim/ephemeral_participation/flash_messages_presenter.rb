# frozen_string_literal: true

module Decidim
  module EphemeralParticipation
    class FlashMessagesPresenter
      def initialize(user, view_helpers)
        @user = user
        @view_helpers = view_helpers
      end

      def unauthorized_ephemeral_participant_message
        I18n.t(
          "decidim.ephemeral_participation.actions.unauthorized",
          link: (
            @view_helpers.link_to(
              I18n.t("decidim.ephemeral_participation.actions.unauthorized_link"),
              decidim_ephemeral_participation.edit_ephemeral_participant_path(@user),
            )
          )
        ).html_safe
      end

      def verified_ephemeral_participant_message
        I18n.t(
          "decidim.ephemeral_participation.actions.verified",
          link: @view_helpers.link_to(
            I18n.t("decidim.ephemeral_participation.actions.verified_link"),
              decidim_ephemeral_participation.edit_ephemeral_participant_path(@user),
          )
        ).html_safe
      end

      def edit_ephemeral_participant_path
        Decidim::EphemeralParticipation::Engine.routes.url_helpers.edit_ephemeral_participant_path(@user)
      end

      def unverified_ephemeral_participant_message
        I18n.t(
          "decidim.ephemeral_participation.actions.unverified",
          link: @view_helpers.link_to(
            I18n.t("decidim.ephemeral_participation.actions.unverified_link"),
            verify_ephemeral_participant_path,
          )
        ).html_safe
      end

      def verify_ephemeral_participant_path
        @user
          .ephemeral_participation_verification_adapter
          .root_path(redirect_url: @user.ephemeral_participation_data["request_path"])
      end

      def decidim_ephemeral_participation
        Decidim::EphemeralParticipation::Engine.routes.url_helpers
      end
    end
  end
end
