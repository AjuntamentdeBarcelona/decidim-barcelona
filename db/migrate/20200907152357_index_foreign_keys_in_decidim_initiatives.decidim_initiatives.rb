# frozen_string_literal: true
# This migration comes from decidim_initiatives (originally 20200320105920)

class IndexForeignKeysInDecidimInitiatives < ActiveRecord::Migration[5.2]
  def change
    add_index :decidim_initiatives, :decidim_user_group_id
    add_index :decidim_initiatives, :scoped_type_id
  end
end
