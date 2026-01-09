# frozen_string_literal: true

# This migration comes from decidim_sortitions (originally 20240828103823)
class AddDeletedAtToDecidimSortitionsSortitions < ActiveRecord::Migration[7.0]
  def change
    add_column :decidim_sortitions_sortitions, :deleted_at, :datetime
    add_index :decidim_sortitions_sortitions, :deleted_at
  end
end
