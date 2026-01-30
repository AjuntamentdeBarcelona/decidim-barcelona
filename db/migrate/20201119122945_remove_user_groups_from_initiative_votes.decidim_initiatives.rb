# frozen_string_literal: true

# This migration comes from decidim_initiatives (originally 20200528151456)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:13 UTC
class RemoveUserGroupsFromInitiativeVotes < ActiveRecord::Migration[5.2]
  def change
    remove_column :decidim_initiatives_votes, :decidim_user_group_id
  end
end
