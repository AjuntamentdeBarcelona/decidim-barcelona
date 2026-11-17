# frozen_string_literal: true

# This migration comes from decidim_extra_censuses (originally 20260520000000)
class AddPositionToDecidimElectionsVotes < ActiveRecord::Migration[7.0]
  def change
    add_column :decidim_elections_votes, :position, :integer
  end
end
