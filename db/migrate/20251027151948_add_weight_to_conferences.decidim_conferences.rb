# frozen_string_literal: true

# This migration comes from decidim_conferences (originally 20221116084952)
class AddWeightToConferences < ActiveRecord::Migration[6.1]
  def change
    add_column :decidim_conferences, :weight, :integer, null: false, default: 0
  end
end
