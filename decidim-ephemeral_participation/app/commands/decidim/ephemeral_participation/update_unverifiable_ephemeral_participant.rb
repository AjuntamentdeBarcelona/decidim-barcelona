# frozen_string_literal: true

module Decidim
  module EphemeralParticipation
    class UpdateUnverifiableEphemeralParticipant   < Rectify::Command
      include ::Devise::Controllers::Helpers

      def initialize(request, user, form)
        @request = request
        @user = user
        @form = form
      end

      def call
        return broadcast(:invalid) unless valid_params?

        if transfer_ephemeral_participant?
          transfer_ephemeral_participant
        else
          update_user
          destroy_session
        end

        broadcast(:ok)
      end

      private

      def valid_params?
        @request.is_a?(ActionDispatch::Request) && @user.is_a?(Decidim::User) && @form.valid? && conflict.present?
      end

      def conflict
        @conflict ||= Decidim::EphemeralParticipation::VerificationConflicts.for(@user).first
      end

      def transfer_ephemeral_participant?
        verified_user.ephemeral_participant? &&
          ephemeral_participation_data(verified_user) == ephemeral_participation_data(@user)
      end

      def verified_user
        conflict.managed_user
      end

      def ephemeral_participation_data(user)
        user.ephemeral_participation_data.values_at(
          :authorization_name,
          :component_id,
          :permissions
        )
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

      def update_unverifiable_user
        @user.email = @form.email

        @user.skip_reconfirmation!
        @user.save(validate: false)
      end

      def destroy_session
        Decidim::EphemeralParticipation::DestroyEphemeralParticipant.call(@request, @user)
      end
    end
  end
end
