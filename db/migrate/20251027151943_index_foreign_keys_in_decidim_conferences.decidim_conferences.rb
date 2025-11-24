# frozen_string_literal: true

# This migration comes from decidim_conferences (originally 20200320105913)
class IndexForeignKeysInDecidimConferences < ActiveRecord::Migration[5.2]
  def change
    add_index :decidim_conferences, :decidim_scope_id
  end
end
