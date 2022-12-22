# frozen_string_literal: true

module Decidim
  module Accountability
    module ResultsCalculatorOverride
      extend ActiveSupport::Concern

      included do
        def progress
          return filtered_results.average("COALESCE(progress, 0)") if component.participatory_space.slug == "PressupostosParticipatius"

          super
        end

        def filtered_results
          Decidim::Accountability::Result.where(id: results.pluck(:id)).where.not(id: Decidim::Accountability::Result.not_computable_results)
        end
      end
    end
  end
end
