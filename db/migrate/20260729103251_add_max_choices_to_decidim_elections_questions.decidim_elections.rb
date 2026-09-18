# frozen_string_literal: true

# This migration comes from decidim_elections (originally 20251007113417)
class AddMaxChoicesToDecidimElectionsQuestions < ActiveRecord::Migration[7.2]
  def change
    add_column :decidim_elections_questions, :max_choices, :integer
  end
end
