# This migration comes from decidim_consultations (originally 20180202133655)
# frozen_string_literal: true

class AddVotesCountToDecidimConsultationsResponse < ActiveRecord::Migration[5.1]
  def change
    add_column :decidim_consultations_responses, :votes_count, :integer, null: false, default: 0
  end
end
