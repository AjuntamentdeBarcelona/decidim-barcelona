# This migration comes from decidim_surveys (originally 20180321141024)
# frozen_string_literal: true

class AddDescriptionToDecidimSurveyQuestions < ActiveRecord::Migration[5.1]
  def change
    add_column :decidim_surveys_survey_questions, :description, :jsonb
  end
end
