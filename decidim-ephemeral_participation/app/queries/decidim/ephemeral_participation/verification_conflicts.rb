# frozen_string_literal: true

module Decidim
  module EphemeralParticipation
    class VerificationConflicts < Decidim::Query
      def self.for(user)
        new(user).query
      end

      def initialize(user)
        @user = user
      end

      def query
        Decidim::Verifications::Conflict.where(current_user: @user)
      end
    end
  end
end
