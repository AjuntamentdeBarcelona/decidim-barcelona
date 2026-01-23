# frozen_string_literal: true

# This migration comes from decidim_budgets (originally 20220428072638)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:12 UTC
class AddGeolocalizationFieldsToProjects < ActiveRecord::Migration[6.1]
  def change
    add_column :decidim_budgets_projects, :address, :text
    add_column :decidim_budgets_projects, :latitude, :float
    add_column :decidim_budgets_projects, :longitude, :float
  end
end
