# frozen_string_literal: true
# This migration comes from decidim_meetings (originally 20180615160839)

class AddCodeToDecidimMeetingsRegistrations < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_meetings_registrations, :code, :string, index: true
  end
end
