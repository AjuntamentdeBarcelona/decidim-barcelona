# frozen_string_literal: true

module Decidim
  module EphemeralParticipation
    module ProjectListItemCellOverride
      def vote_button_disabled?
        return unless current_user
        return if current_user.ephemeral_participant?

        !can_have_order?
      end
    end
  end
end
