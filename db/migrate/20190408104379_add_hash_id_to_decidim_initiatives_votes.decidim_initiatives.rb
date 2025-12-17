# frozen_string_literal: true

# This migration comes from decidim_initiatives (originally 20181224101041)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:13 UTC
class AddHashIdToDecidimInitiativesVotes < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_initiatives_votes, :hash_id, :string
  end
end
