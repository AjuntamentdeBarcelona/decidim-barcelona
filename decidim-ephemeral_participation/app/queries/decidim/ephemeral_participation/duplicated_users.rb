# frozen_string_literal: true

module Decidim
  module EphemeralParticipation
    class DuplicatedUsers < Decidim::Query
      def initialize(organization:, where_clause:, excluding: nil)
        @organization = organization
        @excluding = Array.wrap(excluding).compact.map(&:id)
        @where_clause = where_clause
      end

      def query
        Decidim::User
          .where(organization: @organization)
          .where.not(id: @excluding)
          .where(**@where_clause)
      end
    end
  end
end
