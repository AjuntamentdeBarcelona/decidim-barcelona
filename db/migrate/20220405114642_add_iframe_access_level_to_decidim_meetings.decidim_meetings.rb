# frozen_string_literal: true
# This migration comes from decidim_meetings (originally 20210903143040)

class AddIframeAccessLevelToDecidimMeetings < ActiveRecord::Migration[6.0]
  def change
    add_column :decidim_meetings_meetings, :iframe_access_level, :integer, default: 0
  end
end
