# frozen_string_literal: true

# This migration comes from decidim (originally 20211126183540)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:13 UTC
class AddTimestampsToContentBlocks < ActiveRecord::Migration[6.0]
  def up
    add_timestamps :decidim_content_blocks, default: Time.zone.now
    change_column_default :decidim_content_blocks, :created_at, nil
    change_column_default :decidim_content_blocks, :updated_at, nil
  end

  def down
    remove_column :decidim_content_blocks, :updated_at
    remove_column :decidim_content_blocks, :created_at
  end
end
