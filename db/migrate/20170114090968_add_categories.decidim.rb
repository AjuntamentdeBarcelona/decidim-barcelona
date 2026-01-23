# frozen_string_literal: true

# This migration comes from decidim (originally 20161123085134)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:12 UTC
class AddCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :decidim_categories do |t|
      t.jsonb :name, null: false
      t.jsonb :description, null: false
      t.integer :parent_id, index: true
      t.integer :decidim_participatory_process_id, index: true
    end
  end
end
