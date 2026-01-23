# frozen_string_literal: true

# This migration comes from decidim_proposals (originally 20240110203502)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:13 UTC
class AddStateIdToDecidimProposalsProposals < ActiveRecord::Migration[6.1]
  def up
    add_column :decidim_proposals_proposals, :decidim_proposals_proposal_state_id, :integer, index: true
    add_foreign_key :decidim_proposals_proposals, :decidim_proposals_proposal_states, column: :decidim_proposals_proposal_state_id
  end

  def down
    remove_foreign_key :decidim_proposals_proposals, column: :decidim_proposals_proposal_state_id
    remove_column :decidim_proposals_proposals, :decidim_proposals_proposal_state_id
  end
end
