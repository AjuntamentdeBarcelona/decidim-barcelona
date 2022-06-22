# frozen_string_literal: true
# This migration comes from decidim_decidim_awesome (originally 20200324170000)

class CreateDecidimAwesomeConfig < ActiveRecord::Migration[5.2]
  def change
    create_table :decidim_awesome_config do |t|
      t.jsonb :var
      t.jsonb :value
      t.integer :decidim_organization_id,
                foreign_key: true,
                index: { name: "index_decidim_awesome_on_decidim_organization_id" }

      t.timestamps
      t.index [:var, :decidim_organization_id], name: "index_decidim_awesome_organization_var", unique: true
    end
  end
end
