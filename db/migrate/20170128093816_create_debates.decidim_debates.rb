# frozen_string_literal: true

# This migration comes from decidim_debates (originally 20170118141619)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:13 UTC
class CreateDebates < ActiveRecord::Migration[5.0]
  def change
    create_table :decidim_debates_debates do |t|
      t.jsonb :title
      t.jsonb :description
      t.jsonb :instructions
      t.datetime :start_time
      t.datetime :end_time
      t.string :image
      t.references :decidim_feature, index: true
      t.references :decidim_category, index: true

      t.timestamps
    end
  end
end
