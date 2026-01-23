# frozen_string_literal: true

# This migration comes from decidim_surveys (originally 20250317110501)
class RenameAnswerToResponseInDecidimSurveys < ActiveRecord::Migration[7.0]
  def change
    rename_column :decidim_surveys_surveys, :allow_answers, :allow_responses
    rename_column :decidim_surveys_surveys, :allow_editing_answers, :allow_editing_responses
  end
end
