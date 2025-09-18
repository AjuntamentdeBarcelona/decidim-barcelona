# frozen_string_literal: true

# This migration comes from decidim_proposals (originally 20180529101323)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:13 UTC
class AddCounterCacheCoauthorshipsToProposals < ActiveRecord::Migration[5.1]
  def change
    add_column :decidim_proposals_proposals, :coauthorships_count, :integer, null: false, default: 0
    add_index :decidim_proposals_proposals, :coauthorships_count, name: "idx_decidim_proposals_proposals_on_proposal_coauthorships_count"
  end
end
