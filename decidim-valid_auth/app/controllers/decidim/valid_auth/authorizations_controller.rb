# frozen_string_literal: true

module Decidim
  module ValidAuth
    class AuthorizationsController < Decidim::Verifications::ApplicationController
      def new
        redirect_to valid_link
      end

      private

      def valid_link
        Rails.secrets.valid_auth_url + validate_authorization_url
      end
    end
  end
end