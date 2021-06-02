# frozen_string_literal: true
# This migration comes from decidim_navigation_maps (originally 20191125142751)

class CreateDecidimNavigationMapsBlueprintAreas < ActiveRecord::Migration[5.2]
  def change
    create_table :decidim_navigation_maps_blueprint_areas do |t|
      t.jsonb :area
      t.references :decidim_navigation_maps_blueprint, null: false, foreign_key: true, index: { name: "decidim_navigation_maps_constraint_blueprint_id" }
      t.jsonb :title, default: {}
      t.jsonb :description, default: {}
      t.string :area_type
      t.string :url

      t.timestamps
    end

    remove_column :decidim_navigation_maps_blueprints, :blueprint, :jsonb
  end
end
