# frozen_string_literal: true
# This migration comes from decidim (originally 20200320105909)

class IndexForeignKeysInDecidimAuthorizations < ActiveRecord::Migration[5.2]
  def change
    add_index :decidim_authorizations, :unique_id
  end
end
