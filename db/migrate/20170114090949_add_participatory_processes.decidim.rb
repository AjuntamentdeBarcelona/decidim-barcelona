# frozen_string_literal: true

# This migration comes from decidim (originally 20161005130108)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:13 UTC
class AddParticipatoryProcesses < ActiveRecord::Migration[5.0]
  def change
    create_table :decidim_participatory_processes do |t|
      t.string :title, null: false
      t.string :slug, null: false, unique: true
      t.string :hashtag, unique: true
      t.string :subtitle, null: false
      t.text :short_description, null: false
      t.text :description, null: false
      t.references :decidim_organization,
                   foreign_key: true,
                   index: { name: "index_decidim_processes_on_decidim_organization_id" }

      t.timestamps
    end
  end
end
