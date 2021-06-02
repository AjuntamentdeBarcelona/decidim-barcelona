# frozen_string_literal: true

module Decidim
  module EphemeralParticipation
    class DestroyEphemeralParticipant < Rectify::Command
      include ::Devise::Controllers::Helpers

      def initialize(request, user)
        @request = request
        @user = user
      end

      def call
        return broadcast(:invalid) unless valid_params?

        @user.invalidate_all_sessions!
        delete_pending_authorizations!
        @user.destroy! if destroy_user?
        sign_out(@user)

        broadcast(:ok)
      end

      private

      def valid_params?
        @request.is_a?(ActionDispatch::Request) && @user.is_a?(Decidim::User)
      end

      def delete_pending_authorizations!
        Decidim::Authorization.where(
          user: @user,
          name: @user.ephemeral_participation_data["authorization_name"],
          granted_at: nil,
        ).delete_all
      end

      def destroy_user?
        return false if @user.verified_ephemeral_participant?
        return false if @user.unverifiable_ephemeral_participant?

        true
      end

      # Needed for Devise::Controllers::Helpers#sign_out
      def session
        @request.session
      end

      # Needed for Devise::Controllers::Helpers#sign_out
      def warden
        @request.env['warden']
      end
    end
  end
end
