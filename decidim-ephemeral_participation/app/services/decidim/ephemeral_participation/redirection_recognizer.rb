# frozen_string_literal: true

module Decidim
  module EphemeralParticipation
    class RedirectionRecognizer
      def initialize(request, user)
        @request = request
        @user = user
      end

      def redirect_to_unverifiable_ephemeral_participant_path?
        @user.unverifiable_ephemeral_participant? && (not unverifiable_ephemeral_participant_path?)
      end

      # Handles verification workflows redirecting to authorizations#index after creating authorization.
      def redirect_to_ephemeral_participation_path?
        @user.verified_ephemeral_participant? &&
          @request.method == "GET" &&
            @request.path == decidim_verifications.authorizations_path
      end

      def redirect_to_edit_ephemeral_participant_path?
        return true if path?(decidim.account_path)
        return true if path?(decidim.notifications_settings_path)
        return true if path?(decidim.data_portability_path)
        return true if path?(decidim.own_user_groups_path)
        return true if path?(decidim.user_interests_path)
        return true if path?(decidim.profile_path(@user.nickname))
        return true if path?(decidim.notifications_path)
        return true if path?(decidim.conversations_path)
        
        false
      end

      def unverifiable_ephemeral_participant_path?
        @request.path == decidim_ephemeral_participation.unverifiable_ephemeral_participant_path(@user)
      end

      private

      def path?(path)
        @request.path.include?(path)
      end

      def decidim_ephemeral_participation
        Decidim::EphemeralParticipation::Engine.routes.url_helpers
      end

      def decidim_verifications
        Decidim::Verifications::Engine.routes.url_helpers
      end

      def decidim
        Decidim::Core::Engine.routes.url_helpers
      end
    end
  end
end
