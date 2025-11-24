# frozen_string_literal: true

# This migration comes from decidim_conferences (originally 20240822161330)
class AddDeletedAtToDecidimConferences < ActiveRecord::Migration[7.0]
  def change
    add_column :decidim_conferences, :deleted_at, :datetime
    add_index :decidim_conferences, :deleted_at
  end
end
