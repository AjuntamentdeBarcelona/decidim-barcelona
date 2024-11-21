# frozen_string_literal: true
# This migration comes from decidim_vocdoni (originally 20230217083343)

class AddElectionTypeAttributesToDecidimVocdoniElections < ActiveRecord::Migration[6.1]
  def change
    add_column :decidim_vocdoni_elections, :election_type, :jsonb, default: {}
  end
end
