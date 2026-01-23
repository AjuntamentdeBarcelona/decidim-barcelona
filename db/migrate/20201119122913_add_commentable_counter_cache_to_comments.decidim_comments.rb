# frozen_string_literal: true

# This migration comes from decidim_comments (originally 20200828101910)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:12 UTC
class AddCommentableCounterCacheToComments < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_comments_comments, :comments_count, :integer, null: false, default: 0, index: true
    Decidim::Comments::Comment.reset_column_information
    Decidim::Comments::Comment.find_each(&:update_comments_count)
  end
end
