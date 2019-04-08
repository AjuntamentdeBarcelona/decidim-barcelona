# frozen_string_literal: true
# This migration comes from decidim_proposals (originally 20181026073215)

class AddCreatedInMeeting < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_proposals_proposals, :created_in_meeting, :boolean, default: false
  end
end
