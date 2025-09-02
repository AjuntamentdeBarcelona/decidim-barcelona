# frozen_string_literal: true

# This migration comes from decidim_meetings (originally 20210512055802)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:13 UTC
class CreateDecidimMeetingsPolls < ActiveRecord::Migration[6.0]
  def change
    create_table :decidim_meetings_polls do |t|
      t.references :decidim_meeting, index: true
      t.timestamps
    end
  end
end
