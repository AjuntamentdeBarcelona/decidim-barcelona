# frozen_string_literal: true

# This migration comes from decidim_proposals (originally 20170131092413)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:13 UTC
class AddAnswersToProposals < ActiveRecord::Migration[5.0]
  def change
    add_column :decidim_proposals_proposals, :state, :string, index: true
    add_column :decidim_proposals_proposals, :answered_at, :datetime, index: true
    add_column :decidim_proposals_proposals, :answer, :jsonb
  end
end
