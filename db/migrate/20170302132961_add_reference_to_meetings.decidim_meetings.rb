# frozen_string_literal: true

# This migration comes from decidim_meetings (originally 20170215132546)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:13 UTC
class AddReferenceToMeetings < ActiveRecord::Migration[5.0]
  class Meeting < ApplicationRecord
    self.table_name = :decidim_meetings_meetings
  end

  def change
    add_column :decidim_meetings_meetings, :reference, :string
    Meeting.find_each(&:save)
    change_column_null :decidim_meetings_meetings, :reference, false
  end
end
