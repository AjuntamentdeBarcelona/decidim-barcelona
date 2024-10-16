# frozen_string_literal: true

module Decidim
  module Stats
    # This class serializes a Authorization so can be exported to CSV
    class AuthorizationSerializer < Decidim::Exporters::Serializer
      attr_reader :authorization

      def initialize(authorization)
        @authorization = authorization
      end

      def serialize
        {
          user_hash:,
          date_of_birth: metadata["date_of_birth"],
          postal_code: metadata["postal_code"],
          scope_name: metadata["scope_name"],
          scope_id: metadata["scope_id"],
          scope_code: metadata["scope_code"],
          gender: metadata_extras["gender"],
          granted_at: authorization.granted_at
        }
      end

      private

      def metadata
        authorization.metadata || {}
      end

      def metadata_extras
        metadata["extras"] || {}
      end

      def user_hash
        return "" unless user

        Digest::SHA256.hexdigest(user.id.to_s).last(8)
      end

      def user
        authorization.user
      end
    end
  end
end
