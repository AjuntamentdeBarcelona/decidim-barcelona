# frozen_string_literal: true
# This migration comes from decidim_debates (originally 20200320105918)

class IndexForeignKeysInDecidimDebatesDebates < ActiveRecord::Migration[5.2]
  def change
    add_index :decidim_debates_debates, :decidim_user_group_id
  end
end
