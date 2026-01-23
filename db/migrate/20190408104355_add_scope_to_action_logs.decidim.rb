# frozen_string_literal: true

# This migration comes from decidim (originally 20181211080834)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:12 UTC
class AddScopeToActionLogs < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_action_logs, :decidim_scope_id, :integer
  end
end
