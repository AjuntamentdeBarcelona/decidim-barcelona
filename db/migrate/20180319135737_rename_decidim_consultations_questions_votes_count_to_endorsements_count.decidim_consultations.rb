# This migration comes from decidim_consultations (originally 20180129122504)
# frozen_string_literal: true

class RenameDecidimConsultationsQuestionsVotesCountToEndorsementsCount < ActiveRecord::Migration[5.1]
  def change
    rename_column :decidim_consultations_questions, :votes_count, :endorsements_count
  end
end
