# frozen_string_literal: true
# This migration comes from decidim_navigation_maps (originally 20191127093746)

class AddColorToNavigationMapsBlueprintAreas < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_navigation_maps_blueprint_areas, :color, :string
  end
end
