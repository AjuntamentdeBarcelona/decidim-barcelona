# frozen_string_literal: true

module Decidim
  module EphemeralParticipation
    class InformingRecognizer
      def initialize(request, user)
        @request = request
        @user = user
      end

      def inform_unverified_ephemeral_participant?
        informable_ephemeral_participant? && (not @user.verified_ephemeral_participant?)
      end
      

      def inform_verified_ephemeral_participant?
        informable_ephemeral_participant? && @user.verified_ephemeral_participant?
      end

      def informable_ephemeral_participant?
        return false if verify_ephemeral_participant_path?
        return false if edit_ephemeral_participant_path?
        return false if update_ephemeral_participant_path?
        return false if unverifiable_ephemeral_participant_path?
        return false if @request.flash.any?

        true
      end

      def verify_ephemeral_participant_path?
        adapter = @user.ephemeral_participation_verification_adapter
        engine  = (adapter.type == "direct") ? Decidim::Verifications::Engine : adapter.send(:main_engine)

        engine.routes.recognize_path_with_request(@request.dup, @request.path, method: @request.method)
      rescue ActionController::RoutingError
        false
      end

      private

      def edit_ephemeral_participant_path?
        @request.path == edit_ephemeral_participant_path && @request.method == "GET"
      end

      def edit_ephemeral_participant_path
        Decidim::EphemeralParticipation::Engine.routes.url_helpers.edit_ephemeral_participant_path(@user)
      end

      def update_ephemeral_participant_path?
        @request.path == ephemeral_participant_path && @request.method == "POST"
      end

      def ephemeral_participant_path
        Decidim::EphemeralParticipation::Engine.routes.url_helpers.ephemeral_participant_path(@user)
      end

      def unverifiable_ephemeral_participant_path?
        Decidim::EphemeralParticipation::RedirectionRecognizer
          .new(@request, @user)
          .unverifiable_ephemeral_participant_path?
      end
    end
  end
end
