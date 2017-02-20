# This migration comes from decidim_pages (originally 20170220091402)
class RemovePageFeatureTitles < ActiveRecord::Migration[5.0]
  def change
    remove_column :decidim_pages_pages, :title
  end
end
