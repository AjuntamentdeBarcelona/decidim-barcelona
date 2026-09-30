# frozen_string_literal: true

module Decidim
  module Accountability
    module ResultsControllerOverride
      private

      # Components migrated from the old categories only have the categories as
      # filter items, not the intermediate per-space node between them and the
      # root, so the root has no available direct children and the view renders
      # empty. In that case we show the topmost available taxonomies instead.
      def selected_taxonomy_children
        return super unless taxonomy_children_fallback?

        @selected_taxonomy_children ||= available_taxonomies_under_root.where.not(parent_id: current_component.available_taxonomy_ids)
      end

      def selected_taxonomy_grandchildren?
        return super unless taxonomy_children_fallback?

        @selected_taxonomy_grandchildren ||= available_taxonomies_under_root.exists?(parent_id: selected_taxonomy_children.map(&:id))
      end

      def taxonomy_children_fallback?
        return @taxonomy_children_fallback if defined?(@taxonomy_children_fallback)

        @taxonomy_children_fallback = selected_root_taxonomy.present? &&
                                      !current_organization.taxonomies.exists?(parent_id: selected_root_taxonomy.id, id: current_component.available_taxonomy_ids)
      end

      def available_taxonomies_under_root
        current_organization.taxonomies.part_of(selected_root_taxonomy.id).where(id: current_component.available_taxonomy_ids)
      end
    end
  end
end
