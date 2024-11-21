# frozen_string_literal: true
# This migration comes from decidim_vocdoni (originally 20230306102447)

class AddValuesToDecidimVocdoniAnswers < ActiveRecord::Migration[6.1]
  def change
    add_column :decidim_vocdoni_answers, :value, :integer
  end
end
