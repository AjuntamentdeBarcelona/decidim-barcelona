# frozen_string_literal: true

module Decidim
  module EphemeralParticipation
    module TransferUserOverride
      extend ActiveSupport::Concern

      included do
        alias :update_regular_managed_user :update_managed_user

        private

        def update_managed_user
          if [new_user, managed_user].any?(&:ephemeral_participant?)
            Decidim::EphemeralParticipation::TransferEphemeralParticipant.call(form).tap do |events|
              raise(ActiveRecord::Rollback) if events.key?(:invalid)
            end
          else
            update_regular_managed_user
          end
        end
      end
    end
  end
end
