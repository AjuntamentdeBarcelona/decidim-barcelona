# frozen_string_literal: true

module Decidim
  module EphemeralParticipation
    class EphemeralParticipantsController < Decidim::ApplicationController
      include FormFactory

      def create
        enforce_permission_to(:create, :ephemeral_participant)

        Decidim::EphemeralParticipation::CreateEphemeralParticipant.call(request, current_user) do
          on(:ok) do |authorization_path|
            flash[:notice] = I18n.t("create", scope: "decidim.ephemeral_participation.ephemeral_participants")

            redirect_to(authorization_path)
          end

          on(:invalid) do
            render template: "decidim/errors/not_found", locals: { root_path: decidim_root_path }
          end
        end
      end

      def edit
        enforce_permission_to(:update, :ephemeral_participant, current_user: current_user)

        @form = form(EphemeralParticipantForm).from_model(current_user)
      end

      def update
        enforce_permission_to(:update, :ephemeral_participant, current_user: current_user)

        @form = form(EphemeralParticipantForm).from_params(params)

        Decidim::EphemeralParticipation::UpdateEphemeralParticipant.call(request, current_user, @form) do
          on(:ok) do
            flash[:notice] = I18n.t("update.success", scope: "decidim.ephemeral_participation.ephemeral_participants")

            redirect_to(decidim.account_path)
          end

          on(:invalid) do
            flash[:alert] = I18n.t("update.error", scope: "decidim.ephemeral_participation.ephemeral_participants")

            render(action: :edit)
          end
        end
      end

      def destroy
        enforce_permission_to(:destroy, :ephemeral_participant, current_user: current_user)

        Decidim::EphemeralParticipation::DestroyEphemeralParticipant.call(request, current_user) do
          on(:ok) do
            flash[:notice] = I18n.t("destroy", scope: "decidim.ephemeral_participation.ephemeral_participants")

            redirect_to(decidim_root_path)
          end
        end
      end

      def edit_unverifiable
        enforce_permission_to(:update_unverifiable, :ephemeral_participant, current_user: current_user)

        @form = form(UnverifiableEphemeralParticipantForm).instance
      end

      def update_unverifiable
        enforce_permission_to(:update_unverifiable, :ephemeral_participant, current_user: current_user)

        @form = form(UnverifiableEphemeralParticipantForm).from_params(params)

        Decidim::EphemeralParticipation::UpdateUnverifiableEphemeralParticipant.call(request, current_user, @form) do
          on(:ok) do
            flash[:notice] = I18n.t("update_unverifiable.success", scope: "decidim.ephemeral_participation.ephemeral_participants")

            redirect_to(decidim_root_path)
          end

          on(:invalid) do
            flash[:alert] = I18n.t("update_unverifiable.error", scope: "decidim.ephemeral_participation.ephemeral_participants")

            render(action: :edit_unverifiable)
          end
        end
      end

      private

      def decidim_root_path
        Decidim::Core::Engine.routes.url_helpers.root_path
      end
    end
  end
end
