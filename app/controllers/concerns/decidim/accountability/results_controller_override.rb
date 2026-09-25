# frozen_string_literal: true

module Decidim
  module Accountability
    module ResultsControllerOverride
      extend ActiveSupport::Concern

      included do
        private

        # Same query as the gem (top-level results plus their sub-results), ordered by the
        # admin-defined position, each result followed by its own sub-results.
        def results
          @results ||= begin
            parent_id = params[:parent_id].presence
            search.result.where(
              parent_id: [parent_id] + Result.where(parent_id:).pluck(:id)
            ).ordered_by_position_grouped_by_parent.page(params[:page]).per(12)
          end
        end
      end
    end
  end
end
