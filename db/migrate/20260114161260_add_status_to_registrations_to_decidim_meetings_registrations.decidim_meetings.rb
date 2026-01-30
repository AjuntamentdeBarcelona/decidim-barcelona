# frozen_string_literal: true

# This migration comes from decidim_meetings (originally 20250408071941)
class AddStatusToRegistrationsToDecidimMeetingsRegistrations < ActiveRecord::Migration[7.0]
  def change
    add_column :decidim_meetings_registrations, :status, :string, default: "registered"
    add_index :decidim_meetings_registrations, :status
  end
end
