# frozen_string_literal: true

# This migration comes from decidim_surveys (originally 20170515144119)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:13 UTC
class CreateDecidimSurveyAnswers < ActiveRecord::Migration[5.0]
  def change
    create_table :decidim_surveys_survey_answers do |t|
      t.jsonb :body, default: []
      t.references :decidim_user, index: true
      t.references :decidim_survey, index: true
      t.references :decidim_survey_question, index: { name: "index_decidim_surveys_answers_question_id" }

      t.timestamps
    end
  end
end
