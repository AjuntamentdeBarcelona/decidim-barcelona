# frozen_string_literal: true

# This migration comes from decidim_proposals (originally 20240617170052)
class AddParentRelationToDecidimProposalNotes < ActiveRecord::Migration[7.0]
  def change
    add_reference :decidim_proposals_proposal_notes, :parent, index: { name: :decidim_proposals_proposal_notes_on_parent_id }
  end
end
