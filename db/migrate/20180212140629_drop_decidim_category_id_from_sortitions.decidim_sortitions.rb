# This migration comes from decidim_sortitions (originally 20180103123055)
# frozen_string_literal: true

class DropDecidimCategoryIdFromSortitions < ActiveRecord::Migration[5.1]
  def up
    remove_column :decidim_module_sortitions_sortitions, :decidim_category_id
  end

  def down
    add_reference :decidim_module_sortitions_sortitions, :decidim_category,
                  foreign_key: true,
                  index: { name: "index_sortitions__on_category" }
  end
end
