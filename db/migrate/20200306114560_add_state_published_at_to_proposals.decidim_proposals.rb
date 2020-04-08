# frozen_string_literal: true
# This migration comes from decidim_proposals (originally 20200227175922)

class AddStatePublishedAtToProposals < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_proposals_proposals, :state_published_at, :datetime
  end
end
