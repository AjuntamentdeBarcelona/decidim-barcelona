# frozen_string_literal: true

module Decidim
  module EphemeralParticipation
    module TransferUserFormOverride
      extend ActiveSupport::Concern

      included do
        validate :unique_email

        private

        def unique_email
          return if duplicates(email: email).none?

          errors.add(:email, :taken)
        end

        def duplicates(where_clause)
          Decidim::EphemeralParticipation::DuplicatedUsers.new(
            organization: current_user.organization,
            where_clause: where_clause,
          ).query
        end
      end
    end
  end
end
