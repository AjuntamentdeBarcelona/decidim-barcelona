# frozen_string_literal: true

module Decidim
  module EphemeralParticipation
    class UnverifiableEphemeralParticipantForm < Decidim::Form
      mimic :unverifiable_ephemeral_participant

      attribute :email

      validates :email, presence: true, 'valid_email_2/email': { disposable: true }

      validate :unique_email

      private

      def unique_email
        return if duplicates(email: email).none?

        errors.add(:email, :taken)
      end

      def duplicates(where_clause)
        Decidim::EphemeralParticipation::DuplicatedUsers.new(
          organization: current_organization,
          excluding: current_user,
          where_clause: where_clause,
        ).query
      end
    end
  end
end
