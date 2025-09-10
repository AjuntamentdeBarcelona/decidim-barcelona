# frozen_string_literal: true

# This migration comes from decidim (originally 20161108093802)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:12 UTC
class CreateDecidimStaticPages < ActiveRecord::Migration[5.0]
  def change
    create_table :decidim_static_pages do |t|
      t.jsonb :title, null: false
      t.string :slug, null: false
      t.jsonb :content, null: false
      t.references :decidim_organization, foreign_key: true, index: true
      t.timestamps
    end
  end
end
