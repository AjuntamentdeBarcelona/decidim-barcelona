# frozen_string_literal: true
# This migration comes from decidim_meetings (originally 20210520134834)

class AddStatusToMeetingsQuestions < ActiveRecord::Migration[6.0]
  def change
    add_column :decidim_meetings_questions, :status, :integer, default: 0, index: true
  end
end
