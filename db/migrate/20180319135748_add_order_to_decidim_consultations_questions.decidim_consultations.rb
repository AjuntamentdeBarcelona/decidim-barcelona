# This migration comes from decidim_consultations (originally 20180219092120)
# frozen_string_literal: true

class AddOrderToDecidimConsultationsQuestions < ActiveRecord::Migration[5.1]
  def change
    add_column :decidim_consultations_questions, :order, :integer, index: true
  end
end
