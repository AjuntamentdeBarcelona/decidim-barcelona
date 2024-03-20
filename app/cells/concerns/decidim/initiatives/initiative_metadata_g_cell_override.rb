# frozen_string_literal: true

module Decidim
  module Initiatives
    module InitiativeMetadataGCellOverride
      extend ActiveSupport::Concern

      included do
        def progress_bar_item
          return if %w(created validating discarded).include?(initiative.state)

          type_scope = initiative.votable_initiative_type_scopes[0]

          {
            cell: "decidim/progress_bar",
            args: [initiative.supports_count_for(type_scope.scope), {
              total: initiative.supports_required_for(type_scope.scope),
              element_id: "initiative-#{initiative.id}-votes-count",
              class: "progress-bar__sm"
            }],
            icon: nil
          }
        end
      end
    end
  end
end
