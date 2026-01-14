# frozen_string_literal: true

module Decidim
  module ValidAuth
    class ValidAuthForm < Decidim::AuthorizationHandler
      attribute :token, String

      validates :token_sub, inclusion: { in: ["MCA"] }
      validates :token_iss, inclusion: { in: ["ARQ_IMI_AJBCN"] }
      validates :token_aud, inclusion: { in: ["IMI"] }
      validates :token_status, inclusion: { in: ["ok"] }
      validates :person_identifier, :person_name, :person_surnames, presence: true

      # A person can only be verified once but their data should be private.
      def unique_id
        Digest::MD5.hexdigest(
          "#{person_identifier}-#{person_name}-#{person_surnames}-#{Rails.application.secret_key_base}"
        )
      end

      def handler_name
        "valid_auth"
      end

      def metadata
        {
          assurance_level: token_assurance_level,
          certificate_type: token_certificate_type,
          method: token_method
        }
      end

      def clean_token
        @clean_token ||= JWT.decode(token, nil, false).first
      end

      def token_sub
        clean_token["sub"]
      end

      def token_iss
        clean_token["iss"]
      end

      def token_aud
        clean_token["aud"]
      end

      def token_status
        clean_token["status"]
      end

      def token_assurance_level
        clean_token["assuranceLevel"]
      end

      def token_certificate_type
        clean_token["certificateType"]
      end

      def token_method
        clean_token["method"]
      end

      def person_identifier
        clean_token["identifier"]
      end

      def person_name
        clean_token["name"]
      end

      def person_surnames
        clean_token["surnames"]
      end
    end
  end
end
