# frozen_string_literal: true
# This migration comes from decidim_initiatives (originally 20181224101041)

class AddHashIdToDecidimInitiativesVotes < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_initiatives_votes, :hash_id, :string
  end
end
