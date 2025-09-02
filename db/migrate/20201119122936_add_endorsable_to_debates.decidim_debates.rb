# frozen_string_literal: true

# This migration comes from decidim_debates (originally 20200716143929)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:13 UTC
class AddEndorsableToDebates < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_debates_debates, :endorsements_count, :integer, null: false, default: 0
    add_index :decidim_debates_debates, :endorsements_count, name: "idx_decidim_debates_debates_on_endorsemnts_count"
  end
end
