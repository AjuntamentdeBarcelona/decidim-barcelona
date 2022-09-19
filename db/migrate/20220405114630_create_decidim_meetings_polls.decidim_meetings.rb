# frozen_string_literal: true
# This migration comes from decidim_meetings (originally 20210512055802)

class CreateDecidimMeetingsPolls < ActiveRecord::Migration[6.0]
  def change
    create_table :decidim_meetings_polls do |t|
      t.references :decidim_meeting, index: true
      t.timestamps
    end
  end
end
