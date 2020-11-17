# frozen_string_literal: true
# This migration comes from decidim_comments (originally 20200320105911)

class IndexForeignKeysInDecidimCommentsComments < ActiveRecord::Migration[5.2]
  def change
    add_index :decidim_comments_comments, :decidim_user_group_id
  end
end
