# frozen_string_literal: true
# This migration comes from decidim_navigation_maps (originally 20210112135817)

class AddHeightToNavigationMapsBlueprints < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_navigation_maps_blueprints, :height, :integer, null: false, default: 475
  end
end
