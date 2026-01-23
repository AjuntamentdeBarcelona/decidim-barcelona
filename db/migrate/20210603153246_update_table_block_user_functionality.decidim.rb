# frozen_string_literal: true

# This migration comes from decidim (originally 20201218144706)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:13 UTC
class UpdateTableBlockUserFunctionality < ActiveRecord::Migration[5.2]
  def change
    rename_column :decidim_user_suspensions, :suspending_user_id, :blocking_user_id
    rename_table :decidim_user_suspensions, :decidim_user_blocks
  end
end
