# frozen_string_literal: true

module Decidim
  module EphemeralParticipation
    class TransferEphemeralParticipant < Rectify::Command
      def initialize(verified_user, unverifiable_user, form)
        @verified_user     = verified_user
        @unverifiable_user = unverifiable_user
        @form              = form
      end

      def call
        return broadcast(:invalid) unless valid_params?
        
        update_verified_user
        update_unverifiable_user

        broadcast(:ok)
      end

      private

      def valid_params?
        @verified_user.verified_ephemeral_participant?
      end


      def update_verified_user
        @verified_user.session_token = SecureRandom.hex
        @verified_user.managed = false
        
        @verified_user.email = @form.email

        @verified_user.skip_reconfirmation!
        @verified_user.save!
        @verified_user.send_reset_password_instructions
      end

      def update_unverifiable_user
        Decidim::DestroyAccount.call(
          @unverifiable_user,
          Decidim::DeleteAccountForm.from_params(reason: @form.reason),
        )
      end
    end
  end
end
