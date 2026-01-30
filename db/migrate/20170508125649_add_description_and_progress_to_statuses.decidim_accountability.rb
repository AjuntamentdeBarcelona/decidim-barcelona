# frozen_string_literal: true

# This migration comes from decidim_accountability (originally 20170508104902)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:12 UTC
class AddDescriptionAndProgressToStatuses < ActiveRecord::Migration[5.0]
  def change
    add_column :decidim_accountability_statuses, :description, :jsonb
    add_column :decidim_accountability_statuses, :progress, :integer
  end
end
