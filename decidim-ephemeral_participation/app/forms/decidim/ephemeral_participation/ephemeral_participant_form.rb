# frozen_string_literal: true

module Decidim
  module EphemeralParticipation
    class EphemeralParticipantForm < Decidim::Form
      mimic :ephemeral_participant

      attribute :name
      attribute :nickname
      attribute :email
      attribute :password
      attribute :password_confirmation

      validates :name, presence: true
      validates :email, presence: true, 'valid_email_2/email': { disposable: true }
      validates :nickname, presence: true, format: Decidim::User::REGEXP_NICKNAME
      validates :nickname, length: { maximum: Decidim::User.nickname_max_length, allow_blank: true }
      validates :password, presence: true, confirmation: true
      validates :password, password: { name: :name, email: :email, username: :nickname }
      validates :password_confirmation, presence: true

      validate :unique_email
      validate :unique_nickname

      alias organization current_organization

      private

      def unique_email
        return if duplicates(email: email).none?

        errors.add(:email, :taken)
      end

      def unique_nickname
        return if duplicates(nickname: nickname).none?

        errors.add(:nickname, :taken)
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
