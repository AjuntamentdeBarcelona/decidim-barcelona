# frozen_string_literal: true

# This migration comes from decidim (originally 20170113150627)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:12 UTC
class CreateResourceLinks < ActiveRecord::Migration[5.0]
  def change
    create_table :decidim_resource_links do |t|
      t.references :from, null: false, polymorphic: true, index: true
      t.references :to, null: false, polymorphic: true, index: true
      t.string :name, null: false, index: true
      t.jsonb :data
    end
  end
end
