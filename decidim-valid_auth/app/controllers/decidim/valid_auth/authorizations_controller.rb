# frozen_string_literal: true

module Decidim
  module ValidAuth
    class AuthorizationsController < Decidim::Verifications::ApplicationController
      before_action :load_authorization

      def new
        enforce_permission_to :create, :authorization, authorization: @authorization

        redirect_to valid_link
      end

      private

      def valid_link
        Rails.secrets.valid_auth_url + validate_authorization_url
      end

      def load_authorization
        @authorization = Decidim::Authorization.find_or_initialize_by(
          user: current_user,
          name: "valid"
        )
      end
    end
  end
end