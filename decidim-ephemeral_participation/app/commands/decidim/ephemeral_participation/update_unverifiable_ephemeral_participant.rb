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

        update_user
        destroy_session

        broadcast(:ok)
      end

      private

      def valid_params?
        @request.is_a?(ActionDispatch::Request) && @user.is_a?(Decidim::User) && @form.valid? && conflict.present?
      end

      def conflict
        @conflict ||= Decidim::EphemeralParticipation::VerificationConflicts.for(@user).first
      end

      def update_user
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
