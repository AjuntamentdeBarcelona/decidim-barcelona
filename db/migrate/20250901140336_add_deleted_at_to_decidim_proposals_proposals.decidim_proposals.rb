# frozen_string_literal: true

# This migration comes from decidim_proposals (originally 20240828103755)
class AddDeletedAtToDecidimProposalsProposals < ActiveRecord::Migration[7.0]
  def change
    add_column :decidim_proposals_proposals, :deleted_at, :datetime
    add_index :decidim_proposals_proposals, :deleted_at
  end
end
