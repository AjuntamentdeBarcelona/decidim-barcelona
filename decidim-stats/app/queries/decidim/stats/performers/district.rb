# frozen_string_literal: true

module Decidim
  module Stats
    module Performers
      class District
        def self.available_sections
          Decidim::Scope.pluck(Arel.sql("name -> 'ca'"))
        end

        def initialize(district)
          @district = district
        end

        def query
          Decidim::User
            .where(id: user_ids)
        end

        private

        attr_reader :district

        def user_ids
          Decidim::Authorization
            .where(name: "census_sms_authorization_handler").find_each.map do |authorization|
              authorization.decidim_user_id if authorization.metadata["scope"] == district
            end.compact
        end
      end
    end
  end
end
