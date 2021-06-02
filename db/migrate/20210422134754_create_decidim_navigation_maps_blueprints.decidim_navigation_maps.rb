# frozen_string_literal: true
# This migration comes from decidim_navigation_maps (originally 20191022092624)

class CreateDecidimNavigationMapsBlueprints < ActiveRecord::Migration[5.2]
  def change
    create_table :decidim_navigation_maps_blueprints do |t|
      t.jsonb :blueprint
      t.string :image
      t.references :decidim_organization, null: false, foreign_key: true, index: { name: "decidim_navigation_maps_constraint_organization" }

      t.timestamps
    end
  end
end
