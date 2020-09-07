# frozen_string_literal: true
# This migration comes from decidim_blogs (originally 20200320105910)

class IndexForeignKeysInDecidimBlogsPosts < ActiveRecord::Migration[5.2]
  def change
    add_index :decidim_blogs_posts, :decidim_user_group_id
  end
end
