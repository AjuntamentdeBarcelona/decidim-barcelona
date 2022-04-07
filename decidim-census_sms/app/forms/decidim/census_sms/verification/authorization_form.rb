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

        validates :mobile_phone_number, presence: true
        validates :tos_acceptance, acceptance: true

        # If you need to store any of the defined attributes in the authorization you
        # can do it here.
        #
        # You must return a Hash that will be serialized to the authorization when
        # it's created, and available though authorization.metadata
        def metadata
          super.merge(
            tos_accepted_at: Time.zone.now
          )
        end

        # When there's a phone number, sanitize it allowing only numbers and +.
        def mobile_phone_number
          return unless super

          super.gsub(/[^0-9]/, "")
        end

        # A serialized version of the handler's name.
        #
        # Returns a String.
        def self.handler_name
          "census_sms_authorization_handler"
        end
      end
    end
  end
end
