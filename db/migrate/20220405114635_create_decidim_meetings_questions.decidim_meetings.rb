# frozen_string_literal: true

# This migration comes from decidim_meetings (originally 20210520084253)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:13 UTC
class CreateDecidimMeetingsQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :decidim_meetings_questions do |t|
      t.references :decidim_questionnaire, index: true
      t.integer :position, index: true
      t.string :question_type
      t.jsonb :body
      t.integer :max_choices

      t.timestamps
    end
  end
end
