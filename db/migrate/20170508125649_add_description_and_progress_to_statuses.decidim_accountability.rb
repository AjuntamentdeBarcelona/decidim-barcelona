# This migration comes from decidim_accountability (originally 20170508104902)
class AddDescriptionAndProgressToStatuses < ActiveRecord::Migration[5.0]
  def change
    add_column :decidim_accountability_statuses, :description, :jsonb
    add_column :decidim_accountability_statuses, :progress, :integer
  end
end
