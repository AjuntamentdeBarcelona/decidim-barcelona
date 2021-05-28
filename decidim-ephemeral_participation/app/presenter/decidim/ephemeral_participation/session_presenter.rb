# frozen_string_literal: true

module Decidim
  module EphemeralParticipation
    class SessionPresenter
      EPHEMERAL_PARTICIPANT_SESSION_DURATION = 30.minutes

      def initialize(user, view_helpers)
        @user = user
        @view_helpers = view_helpers
      end

      def ephemeral_participant_session_remaining_time_in_minutes
        (ephemeral_participant_session_remaining_time / 1.minute).round
      end

      def ephemeral_participant_session_expired?
        ephemeral_participant_session_remaining_time.negative?
      end

      private

      def ephemeral_participant_session_remaining_time
        (@user.created_at + EPHEMERAL_PARTICIPANT_SESSION_DURATION) - Time.current
      end
    end
  end
end
