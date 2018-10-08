# frozen_string_literal: true
# This migration comes from decidim_meetings (originally 20180711111023)

class AddValidatedAtToDecidimMeetingsRegistrations < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_meetings_registrations, :validated_at, :datetime
  end
end
