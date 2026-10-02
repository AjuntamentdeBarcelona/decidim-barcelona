# frozen_string_literal: true

module Decidim
  module Accountability
    module ResultOverride
      extend ActiveSupport::Concern

      included do
        before_validation :remove_external_id, if: -> { external_id.blank? }

        # Display order: admin-defined position first (lowest first, as elsewhere in
        # Decidim), results without a position last, ties broken by creation date.
        scope :ordered_by_position, lambda {
          order(Arel.sql(%("#{table_name}"."position" ASC NULLS LAST)), created_at: :asc, id: :asc)
        }

        # Same order for a flat list that mixes top-level results and their sub-results
        # (the public results list): top-level results by position, each one followed by
        # its own sub-results, also by position.
        scope :ordered_by_position_grouped_by_parent, lambda {
          joins(%(LEFT JOIN "#{table_name}" "parents" ON "parents"."id" = "#{table_name}"."parent_id"))
            .order(Arel.sql(<<~SQL.squish))
              CASE WHEN "parents"."id" IS NULL THEN "#{table_name}"."position" ELSE "parents"."position" END ASC NULLS LAST,
              COALESCE("parents"."created_at", "#{table_name}"."created_at") ASC,
              COALESCE("parents"."id", "#{table_name}"."id") ASC,
              "#{table_name}"."parent_id" IS NOT NULL ASC,
              "#{table_name}"."position" ASC NULLS LAST,
              "#{table_name}"."created_at" ASC,
              "#{table_name}"."id" ASC
            SQL
        }

        has_many :children, -> { ordered_by_position },
                 foreign_key: "parent_id",
                 class_name: "Decidim::Accountability::Result",
                 inverse_of: :parent,
                 dependent: :destroy

        def self.not_computable_results
          [11_098, 11_131]
        end

        private

        def remove_external_id
          self.external_id = nil
        end
      end
    end
  end
end
