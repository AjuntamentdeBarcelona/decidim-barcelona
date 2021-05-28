# frozen_string_literal: true

module Decidim
  module EphemeralParticipation
    module TransferUserOverride
      extend ActiveSupport::Concern

      included do
        alias :update_regular_managed_user :update_managed_user

        private

        def update_managed_user
          if managed_user.verified_ephemeral_participant?
            Decidim::EphemeralParticipation::TransferEphemeralParticipant.call(managed_user, new_user, form)
          else
            update_regular_managed_user
          end
        end
      end
    end
  end
end
