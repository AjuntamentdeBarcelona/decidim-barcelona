# frozen_string_literal: true
# This migration comes from decidim_proposals (originally 20191206154128)

class AddEndorsementsCounterCacheToProposals < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_proposals_proposals, :endorsements_count, :integer, null: false, default: 0
  end
end
