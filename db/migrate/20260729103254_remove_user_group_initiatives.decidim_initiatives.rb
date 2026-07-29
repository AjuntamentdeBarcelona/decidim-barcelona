# frozen_string_literal: true

# This migration comes from decidim_initiatives (originally 20260208201403)
class RemoveUserGroupInitiatives < ActiveRecord::Migration[7.0]
  def up
    remove_index :decidim_initiatives, :decidim_user_group_id
    remove_column :decidim_initiatives, :decidim_user_group_id
  end

  def down
    add_column :decidim_initiatives, :decidim_user_group_id, :integer
    add_index :decidim_initiatives, :decidim_user_group_id
  end
end
