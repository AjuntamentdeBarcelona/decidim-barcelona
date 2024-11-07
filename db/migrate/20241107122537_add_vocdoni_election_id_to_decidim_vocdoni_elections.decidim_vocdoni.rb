# frozen_string_literal: true
# This migration comes from decidim_vocdoni (originally 20230114084206)

class AddVocdoniElectionIdToDecidimVocdoniElections < ActiveRecord::Migration[6.1]
  def change
    add_column :decidim_vocdoni_elections, :vocdoni_election_id, :string
  end
end
