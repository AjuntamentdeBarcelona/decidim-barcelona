# frozen_string_literal: true

require "decidim/core/test/factories"

FactoryBot.define do
  factory :census_sms_authorization, parent: :authorization do
    trait :with_code do
      granted_at { nil }

      transient do
        code { "12345" }
      end

      verification_metadata do
        {
          verification_code: code,
          code_sent_at: Time.current
        }
      end
    end

    trait :with_phone_number do
      granted_at { nil }

      transient do
        mobile_phone_number { "(+34) 654321987" }
      end

      verification_metadata do
        {
          mobile_phone_number: Digest::MD5.hexdigest("#{mobile_phone_number.gsub(/[^0-9]/, "")}-#{Rails.application.secret_key_base}")
        }
      end
    end
  end
end
