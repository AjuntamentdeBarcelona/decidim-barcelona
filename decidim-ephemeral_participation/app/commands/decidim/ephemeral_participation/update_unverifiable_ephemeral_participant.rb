# frozen_string_literal: true

module Decidim
  module EphemeralParticipation
    class UpdateUnverifiableEphemeralParticipant < Rectify::Command
      EMAIL_TAKEN_FLAG = "DUPLICATED - "

      include ::Devise::Controllers::Helpers

      def initialize(request, user, form)
        @request = request
        @user = user
        @form = form
      end

      def call
        return broadcast(:invalid) unless valid_params?

        if @form.valid?
          notice = nil

          if verified_user.ephemeral_participant?
            notice = I18n.t("update_unverifiable.success.transfer_user", scope: "decidim.ephemeral_participation.ephemeral_participants")

            discard_last_location
            transfer_ephemeral_participant
          else
            notice = I18n.t("update_unverifiable.success.admin_contact", scope: "decidim.ephemeral_participation.ephemeral_participants")

            update_user
            destroy_session
          end

          broadcast(:ok, notice)
        else
          update_user if @form.email_taken?

          broadcast(:invalid)
        end
      end

      private

      def valid_params?
        @request.is_a?(ActionDispatch::Request) && @user.is_a?(Decidim::User) && conflict.present?
      end

      def conflict
        @conflict ||= Decidim::EphemeralParticipation::VerificationConflicts.for(@user).first
      end

      def verified_user
        conflict.managed_user
      end

      def discard_last_location
        session_key = stored_location_key_for(:user)

        session.delete(session_key)
      end

      def transfer_ephemeral_participant
        Decidim::Admin::TransferUser.call(
          Decidim::Admin::TransferUserForm.from_params(
            current_user: @user,
            conflict: conflict,
            reason: self.class.name,
            email: @form.email,
          )
        )
      end

      def update_user
        @user.email = email

        @user.skip_reconfirmation!
        @user.save(validate: false)
      end

      def email
        @form.email_taken? ? "#{EMAIL_TAKEN_FLAG}#{@form.email}" : @form.email
      end

      def destroy_session
        Decidim::EphemeralParticipation::DestroyEphemeralParticipant.call(@request, @user)
      end
    end
  end
end
