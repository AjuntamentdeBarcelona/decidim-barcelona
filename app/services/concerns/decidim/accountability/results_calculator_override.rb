# frozen_string_literal: true

module Decidim
  module Accountability
    module ResultsCalculatorOverride
      extend ActiveSupport::Concern

      included do
        alias_method :progress_override, :progress

        def progress
          if (ENV["PARTICIPATORY_SPACES_WITH_CUSTOM_ACCOUNTABILITY"] || "").split(",").include?(component.participatory_space.slug)
            return filtered_results.average("COALESCE(progress, 0)")
          end

          progress_override
        end

        def filtered_results
          Decidim::Accountability::Result.where(id: results.pluck(:id)).where.not(id: Decidim::Accountability::Result.not_computable_results)
        end
      end
    end
  end
end
