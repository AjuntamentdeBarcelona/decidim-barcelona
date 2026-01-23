# frozen_string_literal: true

# This migration comes from decidim_pages (originally 20170220091402)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:13 UTC
class RemovePageFeatureTitles < ActiveRecord::Migration[5.0]
  def change
    remove_column :decidim_pages_pages, :title
  end
end
