# frozen_string_literal: true

# This migration comes from decidim_initiatives (originally 20181224100803)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:13 UTC
class AddTimestampToDecidimInitiativesVotes < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_initiatives_votes, :timestamp, :string
  end
end
