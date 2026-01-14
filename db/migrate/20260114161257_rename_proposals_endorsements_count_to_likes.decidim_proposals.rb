# frozen_string_literal: true

# This migration comes from decidim_proposals (originally 20250515132351)
class RenameProposalsEndorsementsCountToLikes < ActiveRecord::Migration[7.0]
  def change
    rename_column :decidim_proposals_proposals, :endorsements_count, :likes_count
  end
end
