# frozen_string_literal: true

# This migration comes from decidim_extra_censuses (originally 20260407120000)
class AddMinChoicesToDecidimElectionsQuestions < ActiveRecord::Migration[7.0]
  def change
    add_column :decidim_elections_questions, :min_choices, :integer
  end
end
