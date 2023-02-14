# frozen_string_literal: true

module Decidim
  module EphemeralParticipation
    class UpdateEphemeralParticipant < Decidim::Command
      include ::Devise::Controllers::Helpers

      def initialize(request, user, form)
        @request = request
        @user = user
        @form = form
      end

      def call
        return broadcast(:invalid) unless valid_params?

        update_user
        bypass_sign_in(@user)

        broadcast(:ok)
      end

      private

      def valid_params?
        @request.is_a?(ActionDispatch::Request) && @user.is_a?(Decidim::User) && @form.valid?
      end

      def update_user
        @user.confirmed_at = Time.now.utc
        @user.managed = false

        @user.name = @form.name
        @user.nickname = @form.nickname
        @user.email = @form.email
        @user.password = @form.password
        @user.password_confirmation = @form.password_confirmation
        @user.password_confirmation = @form.password_confirmation

        @user.skip_reconfirmation!
        @user.save!
        @user.send(:after_confirmation)
      end

      # Needed for Devise::Controllers::Helpers#bypass_sign_in
      def session
        @request.session
      end
    end
  end
end
