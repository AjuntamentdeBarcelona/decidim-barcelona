# frozen_string_literal: true

module Decidim
  module CensusSms
    module Verification
      class AuthorizationsController < Decidim::ApplicationController
        include Decidim::Verifications::Renewable

        helper_method :authorization, :tos_path

        def new
          enforce_permission_to :create, :authorization, authorization: authorization

          @form = AuthorizationForm.new
        end

        def create
          enforce_permission_to :create, :authorization, authorization: authorization

          @form = AuthorizationForm.from_params(create_params)

          Decidim::Verifications::PerformAuthorizationStep.call(authorization, @form) do
            on(:ok) do
              @form = CodeForm.from_params(create_params)

              SendCode.call(@form, authorization) do
                on(:ok) do
                  flash[:notice] = t("authorizations.create.success", scope: "decidim.census_sms.verification")
                  authorization_method = Decidim::Verifications::Adapter.from_element(authorization.name)
                  redirect_to authorization_method.resume_authorization_path(redirect_url: redirect_url)
                end

                on(:invalid) do
                  flash.now[:alert] = t("authorizations.create.error", scope: "decidim.census_sms.verification")
                  render :reset
                end
              end
            end

            on(:invalid) do
              flash.now[:alert] = t("authorizations.create.error", scope: "decidim.census_sms.verification")
              render :new
            end
          end
        end

        def edit
          enforce_permission_to :update, :authorization, authorization: authorization

          @form = Decidim::Verifications::Sms::ConfirmationForm.from_params(params)
        end

        def update
          enforce_permission_to :update, :authorization, authorization: authorization

          @form = Decidim::Verifications::Sms::ConfirmationForm.from_params(params)

          Decidim::Verifications::ConfirmUserAuthorization.call(authorization, @form, session) do
            on(:ok) do
              flash[:notice] = t("authorizations.update.success", scope: "decidim.census_sms.verification")
              redirect_to redirect_url.presence || decidim_verifications.authorizations_path
            end

            on(:invalid) do
              flash.now[:alert] = t("authorizations.update.error", scope: "decidim.census_sms.verification")
              render :edit
            end
          end
        end

        def reset
          enforce_permission_to :update, :authorization, authorization: authorization

          @form = CodeForm.from_params(params)

          return unless request.post?

          SendCode.call(@form, authorization) do
            on(:ok) do
              flash[:notice] = t("authorizations.reset.success", scope: "decidim.census_sms.verification")
              authorization_method = Decidim::Verifications::Adapter.from_element(authorization.name)
              redirect_to authorization_method.resume_authorization_path(redirect_url: redirect_url)
            end

            on(:invalid) do
              flash.now[:alert] = t("authorizations.reset.error", scope: "decidim.census_sms.verification")
              render :reset
            end
          end
        end

        def destroy
          enforce_permission_to :destroy, :authorization, authorization: authorization

          authorization.destroy!
          flash[:notice] = t("authorizations.destroy.success", scope: "decidim.census_sms.verification")

          redirect_to action: :new
        end

        private

        def create_params
          params[:authorization].merge(user: current_user, date_of_birth: date_of_birth)
        end

        def date_of_birth
          year, month, day = params[:authorization].select { |k, _v| k.include?("date_of_birth") }.values.reverse.map(&:to_i)

          Date.new(year, month, day)
        rescue ArgumentError
          nil
        end

        def authorization
          @authorization ||= Decidim::Authorization.find_or_initialize_by(
            user: current_user,
            name: AuthorizationForm.handler_name
          )
        end

        def tos_path
          @terms_and_conditions_page_path ||= decidim.page_path(Decidim::StaticPage.find_by(slug: "terms-and-conditions", organization: current_organization))
        end
      end
    end
  end
end
