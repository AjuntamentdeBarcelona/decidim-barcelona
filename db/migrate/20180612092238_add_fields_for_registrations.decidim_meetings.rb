# This migration comes from decidim_meetings (originally 20180326082611)
# frozen_string_literal: true

class AddFieldsForRegistrations < ActiveRecord::Migration[5.1]
  def change
    add_column :decidim_meetings_meetings, :reserved_slots, :integer, null: false, default: 0
  end
end
