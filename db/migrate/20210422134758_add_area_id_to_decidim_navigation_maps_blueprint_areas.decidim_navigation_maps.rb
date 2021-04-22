# frozen_string_literal: true
# This migration comes from decidim_navigation_maps (originally 20191126154019)

class AddAreaIdToDecidimNavigationMapsBlueprintAreas < ActiveRecord::Migration[5.2]
  class Area < ApplicationRecord
    self.table_name = "decidim_navigation_maps_blueprint_areas"
  end

  def change
    add_column :decidim_navigation_maps_blueprint_areas, :area_id, :string

    Area.find_each do |area|
      area.area_id = area.id
      area.save!
    end
  end
end
