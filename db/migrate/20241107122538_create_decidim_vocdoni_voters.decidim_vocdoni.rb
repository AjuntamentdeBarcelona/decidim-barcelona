# frozen_string_literal: true
# This migration comes from decidim_vocdoni (originally 20230123112353)

class CreateDecidimVocdoniVoters < ActiveRecord::Migration[6.1]
  def change
    create_table :decidim_vocdoni_voters do |t|
      t.string :email
      t.date :born_at
      t.string :wallet_address

      t.references :decidim_vocdoni_election, foreign_key: true, index: true
      t.timestamps
    end
  end
end
