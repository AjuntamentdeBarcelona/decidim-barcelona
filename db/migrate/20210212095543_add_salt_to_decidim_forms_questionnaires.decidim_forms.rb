# frozen_string_literal: true
# This migration comes from decidim_forms (originally 20201110152921)

class AddSaltToDecidimFormsQuestionnaires < ActiveRecord::Migration[5.2]
  class Questionnaire < ApplicationRecord
    self.table_name = :decidim_forms_questionnaires
  end

  def change
    begin
    add_column :decidim_forms_questionnaires, :salt, :string

    Questionnaire.find_each do |questionnaire|
      questionnaire.salt = Decidim::Tokenizer.random_salt
      questionnaire.save!
    end
    rescue ActiveRecord::StatementInvalid
    end
  end
end
