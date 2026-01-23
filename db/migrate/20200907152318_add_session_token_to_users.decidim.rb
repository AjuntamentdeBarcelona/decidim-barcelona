# frozen_string_literal: true

# This migration comes from decidim (originally 20191204075509)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:12 UTC
class AddSessionTokenToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_users, :session_token, :string
  end
end
