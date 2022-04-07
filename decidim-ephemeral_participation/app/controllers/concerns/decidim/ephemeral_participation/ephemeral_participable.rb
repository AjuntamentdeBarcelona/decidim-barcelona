# frozen_string_literal: true

module Decidim
  module EphemeralParticipation
    module EphemeralParticipable
      extend ActiveSupport::Concern

      included do
        include Decidim::EphemeralParticipation::EphemeralParticipationPathsHelper

        before_action :destroy_ephemeral_participant, if: :ephemeral_participant_session?
        before_action :redirect_ephemeral_participant, if: :ephemeral_participant_session?
        before_action :inform_ephemeral_participant, if: :ephemeral_participant_session?

        helper_method :verify_ephemeral_participant_path

        private

        def ephemeral_participant_session?
          current_user && current_user.ephemeral_participant?
        end

        def destroy_ephemeral_participant
          return unless Decidim::EphemeralParticipation::SessionPresenter.new(current_user).ephemeral_participant_session_expired?

          Decidim::EphemeralParticipation::DestroyEphemeralParticipant.call(request, current_user) do
            on(:ok) do
              flash[:notice] = I18n.t("destroy", scope: "decidim.ephemeral_participation.ephemeral_participants")

              redirect_to(Decidim::Core::Engine.routes.url_helpers.root_path)
            end
          end
        end

        def redirect_ephemeral_participant
          return redirect_to(unverifiable_ephemeral_participant_path(current_user)) if redirect_to_unverifiable_ephemeral_participant_path?
          return redirect_to(ephemeral_participation_path) if redirect_to_ephemeral_participation_path?
          return redirect_to(edit_ephemeral_participant_path(current_user)) if redirect_to_edit_ephemeral_participant_path?
        end

        def redirect_to_unverifiable_ephemeral_participant_path?
          current_user.unverifiable_ephemeral_participant? &&
            !destroy_ephemeral_participant_path? &&
            !unverifiable_ephemeral_participant_path?
        end

        def redirect_to_ephemeral_participation_path?
          current_user.verified_ephemeral_participant? && request.method == "GET" && authorizations_path?
        end

        def redirect_to_edit_ephemeral_participant_path?
          user_account_related_path?
        end

        def inform_ephemeral_participant
          presenter = Decidim::EphemeralParticipation::FlashMessagesPresenter.new(current_user, helpers)

          return (flash.now[:warning] = presenter.unverified_ephemeral_participant_message) if inform_unverified_ephemeral_participant?
          return (flash.now[:warning] = presenter.verified_ephemeral_participant_message) if inform_verified_ephemeral_participant?
        end

        def inform_unverified_ephemeral_participant?
          informable_ephemeral_participant? && !current_user.verified_ephemeral_participant?
        end

        def inform_verified_ephemeral_participant?
          informable_ephemeral_participant? && current_user.verified_ephemeral_participant?
        end

        def informable_ephemeral_participant?
          return false if verify_ephemeral_participant_path?
          return false if edit_ephemeral_participant_path?
          return false if update_ephemeral_participant_path?
          return false if unverifiable_ephemeral_participant_path?
          return false if request.flash.any?

          true
        end
      end
    end
  end
end
