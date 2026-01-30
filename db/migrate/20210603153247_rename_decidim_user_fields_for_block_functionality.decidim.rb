# frozen_string_literal: true

# This migration comes from decidim (originally 20201218145252)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:13 UTC
class RenameDecidimUserFieldsForBlockFunctionality < ActiveRecord::Migration[5.2]
  def change
    rename_column :decidim_users, :suspended, :blocked
    rename_column :decidim_users, :suspended_at, :blocked_at
    rename_column :decidim_users, :suspension_id, :block_id
  end
end
