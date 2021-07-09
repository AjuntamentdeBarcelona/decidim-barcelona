# frozen_string_literal: true

module Decidim
  module Stats
    module Performers
      class Gender
        def self.available_sections
          CensusAuthorizationHandler::AVAILABLE_GENDERS
        end

        def initialize(gender)
          @gender = gender
        end

        def query
          Decidim::User
            .where(id: user_ids)
        end

        private

        attr_reader :gender

        def user_ids
          Decidim::Authorization
            .where(name: "census_sms_authorization_handler").find_each.map do |authorization|
              authorization.decidim_user_id if authorization.metadata.dig("extras", "gender").to_s == gender
            end.compact
        end
      end
    end
  end
end
