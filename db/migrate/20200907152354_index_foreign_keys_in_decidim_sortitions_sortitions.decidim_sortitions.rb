# frozen_string_literal: true
# This migration comes from decidim_sortitions (originally 20200320105926)

class IndexForeignKeysInDecidimSortitionsSortitions < ActiveRecord::Migration[5.2]
  def change
    add_index :decidim_sortitions_sortitions, :cancelled_by_user_id
  end
end
