# frozen_string_literal: true

# This migration comes from decidim_conferences (originally 20250605094623)
class RemoveHashtagColumnConferences < ActiveRecord::Migration[7.1]
  def change
    remove_column :decidim_conferences, :hashtag, :string, if_exists: true
  end
end
