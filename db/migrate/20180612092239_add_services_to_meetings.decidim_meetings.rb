# This migration comes from decidim_meetings (originally 20180407110934)
# frozen_string_literal: true

class AddServicesToMeetings < ActiveRecord::Migration[5.1]
  def change
    add_column :decidim_meetings_meetings, :services, :jsonb, default: []
  end
end
