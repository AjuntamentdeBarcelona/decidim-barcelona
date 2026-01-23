# frozen_string_literal: true

# This migration comes from decidim_proposals (originally 20170228105156)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:13 UTC
class AddGeolocalizationFieldsToProposals < ActiveRecord::Migration[5.0]
  def change
    add_column :decidim_proposals_proposals, :address, :text
    add_column :decidim_proposals_proposals, :latitude, :float
    add_column :decidim_proposals_proposals, :longitude, :float
  end
end
