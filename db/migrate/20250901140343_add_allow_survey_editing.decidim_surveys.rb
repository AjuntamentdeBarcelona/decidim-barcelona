# frozen_string_literal: true

# This migration comes from decidim_surveys (originally 20250115193836)
class AddAllowSurveyEditing < ActiveRecord::Migration[7.0]
  def up
    add_column :decidim_surveys_surveys, :allow_editing_answers, :boolean
  end
end
