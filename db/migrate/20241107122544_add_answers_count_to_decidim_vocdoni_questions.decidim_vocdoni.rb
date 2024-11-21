# frozen_string_literal: true
# This migration comes from decidim_vocdoni (originally 20240516163557)

class AddAnswersCountToDecidimVocdoniQuestions < ActiveRecord::Migration[6.1]
  def change
    add_column :decidim_vocdoni_questions, :answers_count, :integer, default: 0, null: false
  end
end
