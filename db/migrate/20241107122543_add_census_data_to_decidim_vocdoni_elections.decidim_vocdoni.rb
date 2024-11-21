# frozen_string_literal: true
# This migration comes from decidim_vocdoni (originally 20231107142971)

class AddCensusDataToDecidimVocdoniElections < ActiveRecord::Migration[6.1]
  def change
    add_column :decidim_vocdoni_elections, :internal_census, :boolean, default: false, null: false
    add_column :decidim_vocdoni_elections, :verification_types, :string, array: true, default: []
    add_column :decidim_vocdoni_elections, :census_attributes, :jsonb, default: {}
    add_column :decidim_vocdoni_elections, :last_census_update_records_added, :integer
    add_column :decidim_vocdoni_elections, :census_last_updated_at, :datetime
    add_column :decidim_vocdoni_voters, :in_vocdoni_census, :boolean, default: false, null: false
  end
end
