# frozen_string_literal: true
# This migration comes from decidim_meetings (originally 20201111133246)

class AddSaltToDecidimMeetings < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_meetings_meetings, :salt, :string
    # we leave old entries empty to maintain the old pad reference
  end
end
