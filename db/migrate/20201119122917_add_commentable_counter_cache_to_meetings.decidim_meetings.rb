# frozen_string_literal: true

# This migration comes from decidim_meetings (originally 20200827153856)
# This file has been modified by `decidim upgrade:migrations` task on 2026-01-14 16:12:36 UTC
class AddCommentableCounterCacheToMeetings < ActiveRecord::Migration[5.2]
  class Meeting < ApplicationRecord
    self.table_name = :decidim_meetings_meetings
    include Decidim::HasComponent
    include Decidim::Comments::CommentableWithComponent
  end

  def change
    add_column :decidim_meetings_meetings, :comments_count, :integer, null: false, default: 0
    Meeting.reset_column_information
    Meeting.unscoped.find_each(&:update_comments_count)
  end
end
