# frozen_string_literal: true

# This migration comes from decidim (originally 20200320105904)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:12 UTC
class IndexForeignKeysInDecidimActionLogs < ActiveRecord::Migration[5.2]
  def change
    add_index :decidim_action_logs, :decidim_area_id
    add_index :decidim_action_logs, :decidim_scope_id
    add_index :decidim_action_logs, :version_id
  end
end
