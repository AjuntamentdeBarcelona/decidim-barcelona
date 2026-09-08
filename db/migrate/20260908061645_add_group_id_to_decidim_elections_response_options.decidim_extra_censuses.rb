# frozen_string_literal: true

# This migration comes from decidim_extra_censuses (originally 20260413000002)
class AddGroupIdToDecidimElectionsResponseOptions < ActiveRecord::Migration[7.0]
  def change
    add_column :decidim_elections_response_options, :group_id, :string
  end
end
