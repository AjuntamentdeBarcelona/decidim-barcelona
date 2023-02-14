# frozen_string_literal: true
# This migration comes from decidim (originally 20220323195258)

class AddIndexToDecidimUsersNotificationsSendingFrequency < ActiveRecord::Migration[6.0]
  def change
    add_index :decidim_users, :notifications_sending_frequency
  end
end
