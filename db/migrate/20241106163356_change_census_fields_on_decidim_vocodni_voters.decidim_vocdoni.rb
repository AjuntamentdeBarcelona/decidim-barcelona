# frozen_string_literal: true
# This migration comes from decidim_vocdoni (originally 20230314115532)

class ChangeCensusFieldsOnDecidimVocodniVoters < ActiveRecord::Migration[6.1]
  def change
    add_column :decidim_vocdoni_voters, :token, :string
    remove_column :decidim_vocdoni_voters, :born_at, :date
  end
end
