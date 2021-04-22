# frozen_string_literal: true
# This migration comes from decidim_navigation_maps (originally 20191120185739)

class AddTitleToNavigationMapsBlueprints < ActiveRecord::Migration[5.2]
  def change
    change_table :decidim_navigation_maps_blueprints do |t|
      t.jsonb :title, default: {}
      t.jsonb :description, default: {}
    end
  end
end
