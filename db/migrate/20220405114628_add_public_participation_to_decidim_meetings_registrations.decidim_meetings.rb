# frozen_string_literal: true
# This migration comes from decidim_meetings (originally 20210430123416)

class AddPublicParticipationToDecidimMeetingsRegistrations < ActiveRecord::Migration[6.0]
  def change
    add_column :decidim_meetings_registrations, :public_participation, :boolean, default: false
  end
end
