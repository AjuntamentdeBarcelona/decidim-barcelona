# frozen_string_literal: true

module Decidim
  module ValidAuth
    class AuthorizationsController < Decidim::Verifications::ApplicationController
      before_action :load_authorization

      def new
        enforce_permission_to :create, :authorization, authorization: @authorization

        redirect_to valid_link
      end

      def validate
        enforce_permission_to :create, :authorization, authorization: @authorization

        @form = ValidAuthForm.from_params(params.merge(user: current_user))

        ValidateValidAuth.call(@authorization, @form) do
          on(:ok) do
            flash[:notice] = t("authorizations.create.success", scope: "decidim.valid_auth")
            redirect_to decidim_verifications.authorizations_path
          end

          on(:invalid) do
            flash[:alert] = t("authorizations.create.error", scope: "decidim.valid_auth")
            redirect_to decidim_verifications.authorizations_path
          end
        end
      end

      private

      def valid_link
        Rails.secrets.valid_auth_url + validate_authorization_url
      end

      def load_authorization
        @authorization = Decidim::Authorization.find_or_initialize_by(
          user: current_user,
          name: "valid_auth"
        )
      end
    end
  end
end