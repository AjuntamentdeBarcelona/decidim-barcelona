# frozen_string_literal: true

# This migration comes from decidim_forms (originally 20200304152939)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:13 UTC
class AddMatrixRowIdToDecidimFormsAnswerChoices < ActiveRecord::Migration[5.2]
  class AnswerChoice < ApplicationRecord
    self.table_name = :decidim_forms_answer_choices
  end

  def change
    add_column :decidim_forms_answer_choices, :decidim_question_matrix_row_id, :integer
  end
end
