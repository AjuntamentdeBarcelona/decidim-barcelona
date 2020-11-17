# frozen_string_literal: true
# This migration comes from decidim (originally 20200320105923)

class IndexForeignKeysInDecidimNotifications < ActiveRecord::Migration[5.2]
  def change
    add_index :decidim_notifications, :decidim_resource_id
  end
end
