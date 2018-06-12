# This migration comes from decidim_surveys (originally 20180405015314)
# frozen_string_literal: true

class AddCustomBodyToSurveyAnswerChoices < ActiveRecord::Migration[5.1]
  def change
    add_column :decidim_surveys_survey_answer_choices, :custom_body, :text
  end
end
