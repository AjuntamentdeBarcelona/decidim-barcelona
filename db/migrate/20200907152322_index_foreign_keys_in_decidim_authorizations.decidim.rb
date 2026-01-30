# frozen_string_literal: true

# This migration comes from decidim (originally 20200320105909)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:13 UTC
class IndexForeignKeysInDecidimAuthorizations < ActiveRecord::Migration[5.2]
  def change
    add_index :decidim_authorizations, :unique_id
  end
end
