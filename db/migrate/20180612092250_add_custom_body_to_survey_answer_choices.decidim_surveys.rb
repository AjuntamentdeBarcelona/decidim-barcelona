# frozen_string_literal: true

# This migration comes from decidim_surveys (originally 20180405015314)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:13 UTC
class AddCustomBodyToSurveyAnswerChoices < ActiveRecord::Migration[5.1]
  def change
    add_column :decidim_surveys_survey_answer_choices, :custom_body, :text
  end
end
