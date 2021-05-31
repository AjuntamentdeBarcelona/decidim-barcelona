# frozen_string_literal: true

# Checks the authorization against the census for Barcelona.
require "digest/md5"

# This class performs a check against the official census database in order
# to verify the citizen's residence and sends an SMS to confirm identity.
module Decidim
  module CensusSms
    module Verification
      class AuthorizationForm < CensusAuthorizationHandler
        attribute :mobile_phone_number, String
        attribute :tos_acceptance, Boolean

        validates :mobile_phone_number, :verification_code, :sms_gateway, presence: true
        validates :tos_acceptance, acceptance: true

        # If you need to store any of the defined attributes in the authorization you
        # can do it here.
        #
        # You must return a Hash that will be serialized to the authorization when
        # it's created, and available though authorization.metadata
        def metadata
          super.merge(
            tos_accepted_at: Time.now,
            mobile_phone_number: mobile_phone_number_hash,
            scope_code: scope.code
          )
        end

        # The verification metadata to validate in the next step.
        def verification_metadata
          {
            verification_code: verification_code,
            code_sent_at: Time.current
          }
       end

        # When there's a phone number, sanitize it allowing only numbers and +.
        def mobile_phone_number
          return unless super

          super.gsub(/[^+0-9]/, "")
        end

        private

        def sms_gateway
          Decidim.sms_gateway_service.to_s.safe_constantize
        end

        def verification_code
          return unless sms_gateway
          return @verification_code if defined?(@verification_code)

          return unless sms_gateway.new(mobile_phone_number, generated_code).deliver_code

          @verification_code = generated_code
        end

        def generated_code
          @generated_code ||= SecureRandom.random_number(1_000_000).to_s
        end

        # A mobile phone can only be verified once but it should be private.
        def mobile_phone_number_hash
          Digest::MD5.hexdigest(
            "#{mobile_phone_number}-#{Rails.application.secrets.secret_key_base}"
          )
        end
      end
    end
  end
end
