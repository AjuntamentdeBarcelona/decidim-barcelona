# frozen_string_literal: true

module Decidim
  module CensusSms
    module Verification
      # A form object to reset verification code and send it again.
      class ResetForm < Form
        attribute :mobile_phone_number, String

        validates :mobile_phone_number, :verification_code, :sms_gateway, presence: true

        # When there's a phone number, sanitize it allowing only numbers and +.
        def mobile_phone_number
          return unless super

          super.gsub(/[^+0-9]/, "")
        end

        # A mobile phone can only be verified once but it should be private.
        def mobile_phone_number_hash
          Digest::MD5.hexdigest(
            "#{mobile_phone_number}-#{Rails.application.secrets.secret_key_base}"
          )
        end

        def generated_code
          @generated_code ||= SecureRandom.random_number(1_000_000).to_s
        end

        private

        def verification_code
          return unless sms_gateway
          return @verification_code if defined?(@verification_code)

          return unless sms_gateway.new(mobile_phone_number, generated_code).deliver_code

          @verification_code = generated_code
        end

        def sms_gateway
          Decidim.sms_gateway_service.to_s.safe_constantize
        end
      end
    end
  end
end
