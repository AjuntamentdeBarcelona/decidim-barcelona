# frozen_string_literal: true

require "csv"

module Decidim
  module Accountability
    # This class handles exporting results to a CSV file.
    # Needs a `current_component` param with a `Decidim::Component`
    class ResultsCsvExporter
      # Public: Initializes the service.
      # component       - A Decidim::component to import the results into.
      def initialize(component)
        @component = component
      end

      def export
        results = Decidim::Accountability::Result
                  .where(component: @component)
                  .includes(:category, :resource_links_from, :resource_links_to)
                  .order(:id)

        CSV.generate(headers: true) do |csv|
          headers = %w(
            result_id
            decidim_category_id
            decidim_scope_id
            parent_id
            external_id
            start_date
            end_date
            decidim_accountability_status_id
            progress
            proposal_ids
            relative_weight
          )

          available_locales = @component.participatory_space.organization.available_locales
          available_locales.each do |locale|
            headers << "title_#{locale}"
            headers << "description_#{locale}"
          end

          csv << headers

          results.find_each do |result|
            row = Rails.cache.fetch("#{result.cache_key}/csv") do
              row_for_result(result, available_locales)
            end

            csv << row
          end
        end
      end

      private

      def row_for_result(result, available_locales)
        row = [
          result.id,
          result.category.try(:id),
          result.decidim_scope_id,
          result.parent_id,
          result.external_id,
          result.start_date,
          result.end_date,
          result.decidim_accountability_status_id,
          result.progress,
          result.resource_links_from.select { |link| link.to_type == "Decidim::Proposals::Proposal" }.map(&:to_id).sort.join(";"),
          (result.weight || 0) * 100.0
        ]
        available_locales.each do |locale|
          row << result.title[locale]
          row << result.description[locale]
        end

        row
      end
    end
  end
end
