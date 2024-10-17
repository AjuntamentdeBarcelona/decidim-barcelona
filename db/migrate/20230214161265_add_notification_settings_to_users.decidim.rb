# frozen_string_literal: true
# This migration comes from decidim (originally 20220127113419)

class AddNotificationSettingsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :decidim_users, :notification_settings, :jsonb, default: {}
  end
end
