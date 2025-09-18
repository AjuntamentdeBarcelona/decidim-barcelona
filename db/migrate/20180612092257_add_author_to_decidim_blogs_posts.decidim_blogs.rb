# frozen_string_literal: true

# This migration comes from decidim_blogs (originally 20171211084630)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:12 UTC
class AddAuthorToDecidimBlogsPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :decidim_blogs_posts, :decidim_author_id, :integer, index: true
  end
end
