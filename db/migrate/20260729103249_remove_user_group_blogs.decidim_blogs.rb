# frozen_string_literal: true

# This migration comes from decidim_blogs (originally 20260208201400)
class RemoveUserGroupBlogs < ActiveRecord::Migration[7.0]
  def up
    remove_index :decidim_blogs_posts, :decidim_user_group_id
    remove_column :decidim_blogs_posts, :decidim_user_group_id
  end

  def down
    add_column :decidim_blogs_posts, :decidim_user_group_id, :integer
    add_index :decidim_blogs_posts, :decidim_user_group_id
  end
end
