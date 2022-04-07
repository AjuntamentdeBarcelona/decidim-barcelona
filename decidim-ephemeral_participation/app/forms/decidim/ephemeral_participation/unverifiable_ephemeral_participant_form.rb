# frozen_string_literal: true

module Decidim
  module EphemeralParticipation
    class UnverifiableEphemeralParticipantForm < Decidim::Form
      mimic :unverifiable_ephemeral_participant

      attribute :email

      validates :email, presence: true, 'valid_email_2/email': { disposable: true }

      def email_taken?
        users_with_same_email.any?
      end

      private

      def users_with_same_email
        @users_with_same_email ||=
          Decidim::EphemeralParticipation::DuplicatedUsers.new(
            organization: current_organization,
            excluding: current_user,
            where_clause: { email: email }
          ).query
      end
    end
  end
end
