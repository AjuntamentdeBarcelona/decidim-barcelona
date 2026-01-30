# frozen_string_literal: true

# This migration comes from decidim (originally 20161213094244)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:12 UTC
class AddAvatarToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :decidim_users, :avatar, :string
  end
end
