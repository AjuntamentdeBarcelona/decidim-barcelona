# frozen_string_literal: true
# This migration comes from decidim_initiatives (originally 20181224100803)

class AddTimestampToDecidimInitiativesVotes < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_initiatives_votes, :timestamp, :string
  end
end
