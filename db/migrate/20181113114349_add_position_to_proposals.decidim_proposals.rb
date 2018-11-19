# frozen_string_literal: true
# This migration comes from decidim_proposals (originally 20180930125321)

class AddPositionToProposals < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_proposals_proposals, :position, :integer
  end
end
