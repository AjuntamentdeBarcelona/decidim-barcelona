# frozen_string_literal: true

module Decidim
  module EphemeralParticipation
    class UpdateUnverifiableEphemeralParticipant < Rectify::Command
      include ::Devise::Controllers::Helpers

      def initialize(request, user, form)
        @request = request
        @user = user
        @form = form
      end

      def call
        return broadcast(:invalid) unless valid_params?

        if transfer_ephemeral_participant?
          set_last_location
          transfer_ephemeral_participant

          broadcast(:ok)
        else
          update_user
          destroy_session

          if @form.email_taken?
            broadcast(:email_taken)
          else
            broadcast(:admin_contact)
          end
        end
      end

      private

      def valid_params?
        @request.is_a?(ActionDispatch::Request) && @user.is_a?(Decidim::User) && @form.valid? && conflict.present?
      end

      def conflict
        @conflict ||= Decidim::EphemeralParticipation::VerificationConflicts.for(@user).first
      end

      def transfer_ephemeral_participant?
        verified_user.ephemeral_participant? && !@form.email_taken?
      end

      def verified_user
        conflict.managed_user
      end

      def set_last_location
        store_location_for(:user, decidim.account_path)
      end

      def transfer_ephemeral_participant
        Decidim::Admin::TransferUser.call(
          Decidim::Admin::TransferUserForm.from_params(
            current_user: @user,
            conflict: conflict,
            reason: self.class.name,
            email: @form.email
          )
        )
      end

      def update_user
        @user.name = flagged_name
        @user.email = flagged_email

        @user.skip_reconfirmation!
        @user.save(validate: false)
      end

      def flagged_name
        if verified_user.ephemeral_participant?
          I18n.t("flagged_name.conflict_with_ephemeral_participant", scope: "decidim.ephemeral_participation.ephemeral_participants.update_unverifiable")
        else
          I18n.t("flagged_name.conflict_with_regular_user", scope: "decidim.ephemeral_participation.ephemeral_participants.update_unverifiable")
        end
      end

      def flagged_email
        if @form.email_taken?
          I18n.t("flagged_email.registered", email: @form.email, scope: "decidim.ephemeral_participation.ephemeral_participants.update_unverifiable")
        else
          I18n.t("flagged_email.unregistered", email: @form.email, scope: "decidim.ephemeral_participation.ephemeral_participants.update_unverifiable")
        end
      end

      def destroy_session
        Decidim::EphemeralParticipation::DestroyEphemeralParticipant.call(@request, @user)
      end
    end
  end
end
