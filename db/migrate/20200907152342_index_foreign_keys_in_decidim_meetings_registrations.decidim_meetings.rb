# frozen_string_literal: true

# This migration comes from decidim_meetings (originally 20200320105922)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:13 UTC
class IndexForeignKeysInDecidimMeetingsRegistrations < ActiveRecord::Migration[5.2]
  def change
    add_index :decidim_meetings_registrations, :decidim_user_group_id
  end
end
