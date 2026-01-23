# frozen_string_literal: true

# This migration comes from decidim_meetings (originally 20180326082611)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:13 UTC
class AddFieldsForRegistrations < ActiveRecord::Migration[5.1]
  def change
    add_column :decidim_meetings_meetings, :reserved_slots, :integer, null: false, default: 0
  end
end
