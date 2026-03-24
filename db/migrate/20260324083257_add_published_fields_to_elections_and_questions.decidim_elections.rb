# frozen_string_literal: true

# This migration comes from decidim_elections (originally 20250616145355)
class AddPublishedFieldsToElectionsAndQuestions < ActiveRecord::Migration[7.2]
  def change
    add_column :decidim_elections_questions, :published_results_at, :datetime
    add_column :decidim_elections_questions, :voting_enabled_at, :datetime
    add_column :decidim_elections_elections, :published_results_at, :datetime
  end
end
