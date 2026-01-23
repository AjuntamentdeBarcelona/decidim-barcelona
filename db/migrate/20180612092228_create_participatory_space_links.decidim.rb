# frozen_string_literal: true

# This migration comes from decidim (originally 20180227131727)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:12 UTC
class CreateParticipatorySpaceLinks < ActiveRecord::Migration[5.0]
  def change
    create_table :decidim_participatory_space_links do |t|
      t.references :from, null: false, polymorphic: true, index: { name: "index_participatory_space_links_on_from" }
      t.references :to, null: false, polymorphic: true, index: { name: "index_participatory_space_links_on_to" }
      t.string :name, null: false, index: { name: "index_participatory_space_links_name" }
      t.jsonb :data
    end
  end
end
