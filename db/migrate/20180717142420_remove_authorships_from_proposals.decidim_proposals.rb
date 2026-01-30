# frozen_string_literal: true

# This migration comes from decidim_proposals (originally 20180529110830)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:13 UTC
class RemoveAuthorshipsFromProposals < ActiveRecord::Migration[5.1]
  def change
    remove_column :decidim_proposals_proposals, :decidim_author_id, :integer
    remove_column :decidim_proposals_proposals, :decidim_user_group_id, :integer
  end
end
