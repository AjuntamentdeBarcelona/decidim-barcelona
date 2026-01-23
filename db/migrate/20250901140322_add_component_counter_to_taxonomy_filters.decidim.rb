# frozen_string_literal: true

# This migration comes from decidim (originally 20241028114430)
class AddComponentCounterToTaxonomyFilters < ActiveRecord::Migration[7.0]
  def change
    add_column :decidim_taxonomy_filters, :components_count, :integer, null: false, default: 0
  end
end
