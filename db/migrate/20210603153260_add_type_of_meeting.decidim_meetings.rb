# frozen_string_literal: true

# This migration comes from decidim_meetings (originally 20201009124057)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:13 UTC
class AddTypeOfMeeting < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_meetings_meetings, :type_of_meeting, :string, default: "in_person"
  end
end
