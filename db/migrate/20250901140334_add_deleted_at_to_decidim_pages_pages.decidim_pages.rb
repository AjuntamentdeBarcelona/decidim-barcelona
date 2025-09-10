# frozen_string_literal: true

# This migration comes from decidim_pages (originally 20240828103537)
class AddDeletedAtToDecidimPagesPages < ActiveRecord::Migration[7.0]
  def change
    add_column :decidim_pages_pages, :deleted_at, :datetime
    add_index :decidim_pages_pages, :deleted_at
  end
end
