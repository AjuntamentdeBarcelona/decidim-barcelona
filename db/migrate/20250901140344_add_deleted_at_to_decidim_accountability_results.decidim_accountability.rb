# frozen_string_literal: true

# This migration comes from decidim_accountability (originally 20240828103202)
class AddDeletedAtToDecidimAccountabilityResults < ActiveRecord::Migration[7.0]
  def change
    add_column :decidim_accountability_results, :deleted_at, :datetime
    add_index :decidim_accountability_results, :deleted_at
  end
end
