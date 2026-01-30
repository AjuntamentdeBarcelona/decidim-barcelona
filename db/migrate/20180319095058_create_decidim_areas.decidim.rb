# frozen_string_literal: true

# This migration comes from decidim (originally 20180215104945)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:12 UTC
class CreateDecidimAreas < ActiveRecord::Migration[5.1]
  def change
    create_table :decidim_areas do |t|
      t.jsonb :name
      t.references :area_type, foreign_key: { to_table: :decidim_area_types }, index: true
      t.references :decidim_organization, foreign_key: true, index: true
      t.timestamps
    end
  end
end
