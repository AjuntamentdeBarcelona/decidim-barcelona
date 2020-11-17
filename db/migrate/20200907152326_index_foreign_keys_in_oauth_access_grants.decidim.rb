# frozen_string_literal: true
# This migration comes from decidim (originally 20200320105927)

class IndexForeignKeysInOAuthAccessGrants < ActiveRecord::Migration[5.2]
  def change
    add_index :oauth_access_grants, :resource_owner_id
  end
end
