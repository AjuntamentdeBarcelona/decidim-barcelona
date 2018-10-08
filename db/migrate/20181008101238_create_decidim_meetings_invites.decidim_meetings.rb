# frozen_string_literal: true
# This migration comes from decidim_meetings (originally 20180607142020)

class CreateDecidimMeetingsInvites < ActiveRecord::Migration[5.2]
  def change
    create_table :decidim_meetings_invites do |t|
      t.references :decidim_user, null: false, index: true
      t.references :decidim_meeting, null: false, index: true
      t.datetime :sent_at
      t.datetime :accepted_at
      t.datetime :rejected_at

      t.timestamps
    end
  end
end
