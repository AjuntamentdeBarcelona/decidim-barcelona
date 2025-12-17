# frozen_string_literal: true

# This migration comes from decidim_meetings (originally 20170129153716)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:13 UTC
class RemoveShortDescriptionFromMeetings < ActiveRecord::Migration[5.0]
  def change
    remove_column :decidim_meetings_meetings, :short_description
  end
end
