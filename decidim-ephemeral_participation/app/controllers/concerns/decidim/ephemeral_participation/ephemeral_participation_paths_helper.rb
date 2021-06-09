# frozen_string_literal: true

module Decidim
  module EphemeralParticipation
    module EphemeralParticipationPathsHelper
      private

      def user_account_related_path?
        [
          decidim.account_path,
          decidim.notifications_settings_path,
          decidim.data_portability_path,
          decidim.own_user_groups_path,
          decidim.user_interests_path,
          decidim.notifications_path,
          decidim.conversations_path,
          decidim.profile_path(current_user.nickname),
        ].any? { |path| request.path.include?(path) }
      end

      def authorizations_path?
        request.path == decidim_verifications.authorizations_path
      end

      def destroy_ephemeral_participant_path?
        delete_params = [
          ["_method", "delete"],
          ["controller", "decidim/ephemeral_participation/ephemeral_participants"],
          ["action", "destroy"],
          ["id", current_user.id.to_s]
        ]

        (delete_params - request.params.to_a).empty?
      end

      def unverifiable_ephemeral_participant_path?
        request.path == unverifiable_ephemeral_participant_path(current_user)
      end

      def unverifiable_ephemeral_participant_path(current_user)
        decidim_ephemeral_participation.unverifiable_ephemeral_participant_path(current_user)
      end

      def edit_ephemeral_participant_path?
        request.path == edit_ephemeral_participant_path(current_user) && request.method == "GET"
      end

      def edit_ephemeral_participant_path(current_user)
        decidim_ephemeral_participation.edit_ephemeral_participant_path(current_user)
      end

      def ephemeral_participation_path
        current_user.ephemeral_participation_data["request_path"]
      end

      def update_ephemeral_participant_path?
        request.path == ephemeral_participant_path && request.method == "POST"
      end

      def ephemeral_participant_path
        decidim_ephemeral_participation.ephemeral_participant_path(current_user)
      end

      def verify_ephemeral_participant_path?
        return false if homepage?

        adapter = ephemeral_participation_verification_adapter
        engine  = (adapter.type == "direct") ? Decidim::Verifications::Engine : adapter.send(:main_engine)

        engine.routes.recognize_path_with_request(request.dup, request.path, method: request.method)
      rescue ActionController::RoutingError
        false
      end

      def homepage?
        request.path == "/"
      end

      def verify_ephemeral_participant_path
        adapter = ephemeral_participation_verification_adapter

        if pending_authorization?
          adapter.resume_authorization_path(redirect_url: ephemeral_participation_path)
        else
          adapter.root_path(redirect_url: ephemeral_participation_path)
        end
      end

      def ephemeral_participation_verification_adapter
        Decidim::Verifications::Adapter.from_element(current_user.ephemeral_participation_data["authorization_name"])
      end

      def pending_authorization?
        Decidim::Authorization.where(
          user: current_user,
          name: current_user.ephemeral_participation_data["authorization_name"],
          granted_at: nil,
        ).exists?
      end

      def decidim
        Decidim::Core::Engine.routes.url_helpers
      end

      def decidim_ephemeral_participation
        Decidim::EphemeralParticipation::Engine.routes.url_helpers
      end

      def decidim_verifications
        Decidim::Verifications::Engine.routes.url_helpers
      end
    end
  end
end
