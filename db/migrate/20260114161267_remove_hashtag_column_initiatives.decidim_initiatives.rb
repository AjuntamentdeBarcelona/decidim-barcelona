# frozen_string_literal: true

# This migration comes from decidim_initiatives (originally 20250605104500)
class RemoveHashtagColumnInitiatives < ActiveRecord::Migration[7.1]
  def change
    remove_column :decidim_initiatives, :hashtag, :string, if_exists: true
  end
end
