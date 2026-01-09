# frozen_string_literal: true

# This migration comes from decidim_surveys (originally 20170515090916)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:13 UTC
class CreateDecidimSurveyQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :decidim_surveys_survey_questions do |t|
      t.jsonb :body
      t.references :decidim_survey, index: true

      t.timestamps
    end
  end
end
