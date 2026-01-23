# frozen_string_literal: true

# This migration comes from decidim_meetings (originally 20240828103603)
class AddDeletedAtToDecidimMeetingsMeetings < ActiveRecord::Migration[7.0]
  def change
    add_column :decidim_meetings_meetings, :deleted_at, :datetime
    add_index :decidim_meetings_meetings, :deleted_at
  end
end
