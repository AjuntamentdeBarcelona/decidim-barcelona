# frozen_string_literal: true
# This migration comes from decidim_meetings (originally 20210520084330)

class CreateDecidimMeetingsAnswerOptions < ActiveRecord::Migration[6.0]
  def change
    create_table :decidim_meetings_answer_options do |t|
      t.references :decidim_question, index: { name: "index_decidim_meetings_answer_options_question_id" }
      t.jsonb :body
    end
  end
end
