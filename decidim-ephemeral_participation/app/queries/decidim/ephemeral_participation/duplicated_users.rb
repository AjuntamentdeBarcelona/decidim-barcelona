# frozen_string_literal: true

module Decidim
  module EphemeralParticipation
    class DuplicatedUsers < Rectify::Query
      def initialize(organization:, excluding: nil, where_clause:)
        @organization = organization
        @excluding    = Array.wrap(excluding).compact.map(&:id)
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
