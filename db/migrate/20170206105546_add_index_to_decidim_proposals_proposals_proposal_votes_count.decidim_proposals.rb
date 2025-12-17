# frozen_string_literal: true

# This migration comes from decidim_proposals (originally 20170205082832)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:13 UTC
class AddIndexToDecidimProposalsProposalsProposalVotesCount < ActiveRecord::Migration[5.0]
  def change
    add_index :decidim_proposals_proposals, :proposal_votes_count
    add_index :decidim_proposals_proposals, :created_at
    add_index :decidim_proposals_proposals, :state
  end
end
