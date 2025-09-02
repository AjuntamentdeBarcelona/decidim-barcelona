# frozen_string_literal: true

# This migration comes from decidim_surveys (originally 20200610090845)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:13 UTC
class RemoveSurveyQuestions < ActiveRecord::Migration[5.2]
  def change
    drop_table :decidim_surveys_survey_questions, if_exists: true
  end
end
