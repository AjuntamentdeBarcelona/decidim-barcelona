# frozen_string_literal: true
# This migration comes from decidim_forms (originally 20210616153042)

class SetPositionToQuestionMatrixRows < ActiveRecord::Migration[5.2]
  def up
    execute "UPDATE decidim_forms_question_matrix_rows SET position = id"
  end

  def down
    execute "UPDATE decidim_forms_question_matrix_rows SET position = NULL"
  end
end
