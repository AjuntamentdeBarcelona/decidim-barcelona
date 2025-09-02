# frozen_string_literal: true

# This migration comes from decidim_debates (originally 20210125101735)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:13 UTC
class RevertArchiveDebates < ActiveRecord::Migration[5.2]
  def change
    remove_index :decidim_debates_debates, :archived_at
    remove_column :decidim_debates_debates, :archived_at
  end
end
