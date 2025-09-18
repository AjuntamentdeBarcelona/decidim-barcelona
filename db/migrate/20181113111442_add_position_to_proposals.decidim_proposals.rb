# frozen_string_literal: true

# This migration comes from decidim_proposals (originally 20180930125321)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:13 UTC
class AddPositionToProposals < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_proposals_proposals, :position, :integer
  end
end
