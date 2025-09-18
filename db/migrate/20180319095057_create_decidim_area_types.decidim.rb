# frozen_string_literal: true

# This migration comes from decidim (originally 20180215104821)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:12 UTC
class CreateDecidimAreaTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :decidim_area_types do |t|
      t.references :decidim_organization, foreign_key: true, index: true
      t.jsonb :name, null: false
      t.jsonb :plural, null: false
    end
  end
end
