# frozen_string_literal: true

# This migration comes from decidim_blogs (originally 20240828103324)
class AddDeletedAtToDecidimBlogsPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :decidim_blogs_posts, :deleted_at, :datetime
    add_index :decidim_blogs_posts, :deleted_at
  end
end
