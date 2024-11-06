# frozen_string_literal: true
# This migration comes from decidim_vocdoni (originally 20230112144820)

class AddDescriptionToDecidimVocdoniQuestions < ActiveRecord::Migration[6.1]
  def change
    add_column :decidim_vocdoni_questions, :description, :jsonb
  end
end
