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
            .where(name: "census_handler_authorization")
            .where("metadata @> ?", { scope: district }.to_json)
            .pluck(:decidim_user_id)
        end
      end
    end
  end
end
