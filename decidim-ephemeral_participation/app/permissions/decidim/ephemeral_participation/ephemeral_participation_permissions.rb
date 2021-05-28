# frozen_string_literal: true

require_relative "ephemeral_action_permissions_dictionary"

module Decidim
  module EphemeralParticipation
    class EphemeralParticipationPermissions < DefaultPermissions
      def permissions
        return permission_action if regular_user?
        return permission_action if permission_action.disallowed?

        if create_ephemeral_participant?
          allow!    if allowed_to_create_ephemeral_participant?
        elsif update_ephemeral_participant?
          allow!    if allowed_to_update_ephemeral_participant?
        elsif destroy_ephemeral_participant?
          allow!    if allowed_to_destroy_ephemeral_participant?
        elsif update_profile?
          disallow! unless allowed_to_update_profile?
        else
          disallow! unless allowed_ephemeral_participation?
        end

        permission_action
      end

      private

      def regular_user?
        user && (not user.ephemeral_participant?)
      end

      def create_ephemeral_participant?
        permission_action.action == :create &&
          permission_action.scope == :public &&
            permission_action.subject == :ephemeral_participant
      end

      def allowed_to_create_ephemeral_participant?
        return true if user.nil?
        return true if (not user.verified_ephemeral_participant?)
        
        false
      end

      def destroy_ephemeral_participant?
        permission_action.action == :destroy &&
        permission_action.scope == :public &&
          permission_action.subject == :ephemeral_participant
      end

      def allowed_to_destroy_ephemeral_participant?
        user && user == context[:current_user]
      end

      def update_ephemeral_participant?
        permission_action.action == :update &&
        permission_action.scope == :public &&
          permission_action.subject == :ephemeral_participant
      end

      def allowed_to_update_ephemeral_participant?
        user && user == context[:current_user] && user.verifiable_ephemeral_participant?
      end

      def update_profile?
        permission_action.action == :update_profile &&
          permission_action.scope == :public &&
            permission_action.subject == :user
      end

      def allowed_to_update_profile?
        verify_ephemeral_participant_path? && (not user.verified_ephemeral_participant?)
      end

      def verify_ephemeral_participant_path?
        Decidim::EphemeralParticipation::InformingRecognizer.new(context[:request], user).verify_ephemeral_participant_path?
      end

      def decidim_verifiations
        Decidim::Verifications::Engine.routes.url_helpers
      end

      def allowed_ephemeral_participation?
        return true if browsing_public_pages?
        return true if changing_locales?
        return true if user && user.verified_ephemeral_participant? && ephemeral_participation_permission_action?

        false
      end

      def browsing_public_pages?
        permission_action.scope == :public && [:read, :list].include?(permission_action.action)
      end

      def changing_locales?
        permission_action.action == :create &&
          permission_action.scope == :public &&
            permission_action.subject == :locales
      end

      def ephemeral_participation_permission_action?
        Decidim::EphemeralParticipation::EphemeralActionPermissionsDictionary.for(component)
          .any? do |_, permission_action_attributes|
            permission_action_attributes.any? do |action:, scope:, subject:|
              permission_action.matches?(scope, action, subject)
            end
          end
      end
    end
  end
end
