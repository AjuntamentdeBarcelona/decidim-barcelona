# frozen_string_literal: true
# This migration comes from decidim_surveys (originally 20200610090533)

class RemoveSurveyAnswerChoices < ActiveRecord::Migration[5.2]
  def change
    drop_table :decidim_surveys_survey_answer_choices, if_exists: true
  end
end
