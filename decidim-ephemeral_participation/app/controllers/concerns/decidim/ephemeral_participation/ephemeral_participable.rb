# frozen_string_literal: true

module Decidim
  module EphemeralParticipation
    module EphemeralParticipable
      extend ActiveSupport::Concern

      included do
        before_action :destroy_ephemeral_participant,  if: :ephemeral_participant_session?
        before_action :redirect_ephemeral_participant, if: :ephemeral_participant_session?
        before_action :inform_ephemeral_participant,   if: :ephemeral_participant_session?

        private

        def ephemeral_participant_session?
          current_user && current_user.ephemeral_participant?
        end

        def destroy_ephemeral_participant
          return unless Decidim::EphemeralParticipation::SessionPresenter.new(current_user, helpers).ephemeral_participant_session_expired?

          Decidim::EphemeralParticipation::DestroyEphemeralParticipant.call(request, current_user) do
            on(:ok) do
              flash[:notice] = I18n.t("destroy", scope: "decidim.ephemeral_participation.ephemeral_participants")

              redirect_to(Decidim::Core::Engine.routes.url_helpers.root_path)
            end
          end
        end

        def redirect_ephemeral_participant
          return redirect_to(unverifiable_ephemeral_participant_path(current_user)) if redirect_to_unverifiable_ephemeral_participant_path?
          return redirect_to(ephemeral_participation_path)                          if redirect_to_ephemeral_participation_path?
          return redirect_to(edit_ephemeral_participant_path(current_user))         if redirect_to_edit_ephemeral_participant_path?
        end

        def unverifiable_ephemeral_participant_path(current_user)
          Decidim::EphemeralParticipation::Engine.routes.url_helpers.unverifiable_ephemeral_participant_path(current_user)
        end

        def redirect_to_unverifiable_ephemeral_participant_path?
          Decidim::EphemeralParticipation::RedirectionRecognizer.new(request, current_user).redirect_to_unverifiable_ephemeral_participant_path?
        end

        def ephemeral_participation_path
          current_user.ephemeral_participation_data["request_path"]
        end

        def redirect_to_ephemeral_participation_path?
          Decidim::EphemeralParticipation::RedirectionRecognizer.new(request, current_user).redirect_to_ephemeral_participation_path?
        end

        def edit_ephemeral_participant_path(current_user)
          Decidim::EphemeralParticipation::Engine.routes.url_helpers.edit_ephemeral_participant_path(current_user)
        end

        def redirect_to_edit_ephemeral_participant_path?
          Decidim::EphemeralParticipation::RedirectionRecognizer.new(request, current_user).redirect_to_edit_ephemeral_participant_path?
        end

        def inform_ephemeral_participant
          return (flash.now[:warning] = unverified_ephemeral_participant_message) if inform_unverified_ephemeral_participant?
          return (flash.now[:warning] = verified_ephemeral_participant_message)   if inform_verified_ephemeral_participant?
        end

        def unverified_ephemeral_participant_message
          Decidim::EphemeralParticipation::FlashMessagesPresenter.new(current_user, helpers).unverified_ephemeral_participant_message
        end

        def inform_unverified_ephemeral_participant?
          Decidim::EphemeralParticipation::InformingRecognizer.new(request, current_user).inform_unverified_ephemeral_participant?
        end

        def verified_ephemeral_participant_message
          Decidim::EphemeralParticipation::FlashMessagesPresenter.new(current_user, helpers).verified_ephemeral_participant_message
        end

        def inform_verified_ephemeral_participant?
          Decidim::EphemeralParticipation::InformingRecognizer.new(request, current_user).inform_verified_ephemeral_participant?
        end
      end
    end
  end
end
