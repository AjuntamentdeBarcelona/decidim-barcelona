# frozen_string_literal: true
# This migration comes from decidim (originally 20191204075509)

class AddSessionTokenToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_users, :session_token, :string
  end
end
