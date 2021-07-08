# frozen_string_literal: true

module Decidim
  module Stats
    module Performers
      class AgeGroup
        def self.available_sections
          %w(14-19 20-24 25-29 30-34 35-39 40-44 45-49 50-54 55-59 60-64 65-69 >70)
        end

        def initialize(age_group)
          @age_group = age_group
        end

        def query
          Decidim::User
            .where(id: user_ids)
        end

        private

        attr_reader :age_group

        def user_ids
          Decidim::Authorization
            .where(name: "census_sms_authorization_handler")
            .where("metadata ->> 'date_of_birth' >= ?", birth_limits[:old])
            .where("metadata ->> 'date_of_birth' < ?", birth_limits[:young])
            .pluck(:decidim_user_id)
        end

        def birth_limits
          {
            old: Time.zone.today - age_range[1].years,
            young: Time.zone.today - (age_range[0] - 1).years + 1.day
          }
        end

        def age_range
          @age_range ||=
            if age_group == ">70"
              [70, 9999]
            else
              age_group.split("-").map(&:to_i)
            end
        end
      end
    end
  end
end
