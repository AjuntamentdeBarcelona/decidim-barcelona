# frozen_string_literal: true

# This migration comes from decidim (originally 20170202084913)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:12 UTC
class AddCommentsAndRepliesNotificationsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :decidim_users, :comments_notifications, :boolean, null: false, default: false
    add_column :decidim_users, :replies_notifications, :boolean, null: false, default: false
  end
end
