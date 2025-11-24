# frozen_string_literal: true

# This migration comes from decidim_conferences (originally 20240613095855)
class AddPublishedAtToConferenceSpeakers < ActiveRecord::Migration[7.0]
  def change
    add_column :decidim_conference_speakers, :published_at, :datetime, index: true
  end
end
