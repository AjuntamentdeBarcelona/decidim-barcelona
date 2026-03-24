# frozen_string_literal: true

# This migration comes from decidim_elections (originally 20250521101318)
class AddCensusFieldsToDecidimElectionsElections < ActiveRecord::Migration[7.0]
  def change
    remove_column :decidim_elections_elections, :census_type
    add_column :decidim_elections_elections, :census_manifest, :string
    add_column :decidim_elections_elections, :census_settings, :jsonb, default: {}, null: false

    add_index :decidim_elections_elections, :census_manifest
  end
end
