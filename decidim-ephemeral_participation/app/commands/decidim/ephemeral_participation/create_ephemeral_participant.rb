# frozen_string_literal: true

module Decidim
  module EphemeralParticipation
    class CreateEphemeralParticipant < Rectify::Command
      include ::Devise::Controllers::Helpers

      def initialize(request, current_user)
        @request = request
        @current_user = current_user
      end

      def call
        return broadcast(:invalid) unless valid_params?

        sign_in(new_ephemeral_participant) unless @current_user

        broadcast(:ok, authorization_path)
      end

      private

      def valid_params?
        @request.is_a?(ActionDispatch::Request) && component_id.present? && ephemeral_participation_path.present?
      end

      def component_id
        @request.params[:component_id]
      end

      def ephemeral_participation_path
        @request.params[:ephemeral_participation_path]
      end

      def new_ephemeral_participant
        Decidim::User.new(
          organization: component.organization,
          managed: true,
          tos_agreement: true,
          accepted_tos_version: component.organization.tos_version,
          name: I18n.t("decidim.ephemeral_participation.ephemeral_participants.name"),
          extended_data: {
            ephemeral_participation: {
              authorization_name: authorization_name,
              component_id: component.id,
              permissions:  component.ephemeral_participation_permissions,
              request_path: ephemeral_participation_path
            }
          }
        ).tap do |user|
          user.nickname = nicknamize(user)
          user.save!
        end
      end

      # nickname is needed to ensure some links are not broken
      def nicknamize(user)
        Decidim::UserBaseEntity.nicknamize(user.name, organization: user.organization)
      end

      def authorization_path
        adapter.root_path(redirect_url: ephemeral_participation_path)
      end

      def adapter
        @adapter ||= Decidim::Verifications::Adapter.from_element(authorization_name)
      end

      def authorization_name
        component.organization.ephemeral_participation_authorization
      end

      def component
        @component ||= Decidim::Component.find(component_id)
      end

      # Needed for Devise::Controllers::Helpers#sign_in
      def session
        @request.session
      end
    end
  end
end
