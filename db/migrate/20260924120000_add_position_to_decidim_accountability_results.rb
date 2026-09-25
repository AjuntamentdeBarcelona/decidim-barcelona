# frozen_string_literal: true

# Display order for accountability results. `weight` is kept untouched because
# it is the coefficient used by the weighted progress calculation (PAM 2016-2019).
class AddPositionToDecidimAccountabilityResults < ActiveRecord::Migration[8.1]
  def change
    add_column :decidim_accountability_results, :position, :integer
    add_index :decidim_accountability_results, [:decidim_component_id, :position],
              name: "index_decidim_accountability_results_on_component_and_position"
  end
end
