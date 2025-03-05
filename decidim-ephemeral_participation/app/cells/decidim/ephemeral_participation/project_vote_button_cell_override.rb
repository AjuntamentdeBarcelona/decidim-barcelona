# frozen_string_literal: true

module Decidim
  module EphemeralParticipation
    module ProjectVoteButtonCellOverride
      def vote_button_disabled?
        return false unless current_user
        return false if current_user.ephemeral_participant?

        !can_have_order?
      end
    end
  end
end
