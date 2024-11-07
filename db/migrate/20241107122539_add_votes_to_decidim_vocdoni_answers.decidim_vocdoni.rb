# frozen_string_literal: true
# This migration comes from decidim_vocdoni (originally 20230215092726)

class AddVotesToDecidimVocdoniAnswers < ActiveRecord::Migration[6.1]
  def change
    add_column :decidim_vocdoni_answers, :votes, :integer
  end
end
