# frozen_string_literal: true

# This migration comes from decidim_extra_censuses (originally 20260605000001)
class AddSettingsToDecidimElectionsResponseOptions < ActiveRecord::Migration[7.0]
  def change
    add_column :decidim_elections_response_options, :settings, :jsonb, default: {}, null: false
  end
end
