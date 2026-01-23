# frozen_string_literal: true

# This migration comes from decidim_meetings (originally 20240712104245)
class CreateDecidimMeetingsMeetingLink < ActiveRecord::Migration[7.0]
  def change
    create_table :decidim_meetings_meeting_links do |t|
      t.references :decidim_component, null: false, index: true
      t.references :decidim_meeting, null: false, index: true

      t.timestamps
    end
  end
end
