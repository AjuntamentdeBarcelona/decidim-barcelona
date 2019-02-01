# frozen_string_literal: true
# This migration comes from decidim (originally 20181211090933)

class AddAreaToActionLogs < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_action_logs, :decidim_area_id, :integer
  end
end
