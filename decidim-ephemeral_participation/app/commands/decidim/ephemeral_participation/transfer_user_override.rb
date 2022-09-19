# frozen_string_literal: true

module Decidim
  module EphemeralParticipation
    module TransferUserOverride
      extend ActiveSupport::Concern

      included do
        alias_method :update_regular_managed_user, :update_managed_user

        def call
          return broadcast(:invalid) unless form.valid?

          transaction do
            update_managed_user
            mark_conflict_as_solved
            create_action_log
          end

          if form.conflict.reload.solved?
            broadcast(:ok)
          else
            broadcast(:invalid)
          end
        end

        private

        def update_managed_user
          if [new_user, managed_user].any?(&:ephemeral_participant?)
            Decidim::EphemeralParticipation::TransferEphemeralParticipant.call(form).tap do |events|
              raise(ActiveRecord::Rollback) if events.has_key?(:invalid)
            end
          else
            update_regular_managed_user
          end
        end
      end
    end
  end
end
