# frozen_string_literal: true

# This migration comes from decidim (originally 20250221091348)
class AddApiKeyToDecidimApiUser < ActiveRecord::Migration[7.0]
  def change
    add_column :decidim_users, :api_key, :string
  end
end
