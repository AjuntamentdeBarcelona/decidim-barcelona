# This migration comes from decidim_debates (originally 20180305092347)
# frozen_string_literal: true

class DropCategoryIdColumn < ActiveRecord::Migration[5.1]
  def change
    remove_column :decidim_debates_debates, :decidim_category_id
  end
end
