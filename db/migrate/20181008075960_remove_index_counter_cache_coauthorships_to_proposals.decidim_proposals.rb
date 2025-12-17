# frozen_string_literal: true

# This migration comes from decidim_proposals (originally 20180711075004)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:13 UTC
class RemoveIndexCounterCacheCoauthorshipsToProposals < ActiveRecord::Migration[5.2]
  def change
    remove_index :decidim_proposals_proposals, name: "idx_decidim_proposals_proposals_on_proposal_coauthorships_count"
  end
end
