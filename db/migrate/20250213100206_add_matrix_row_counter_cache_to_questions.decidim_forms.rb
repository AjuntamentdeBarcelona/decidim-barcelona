# frozen_string_literal: true

# This migration comes from decidim_forms (originally 20240402095253)
class AddMatrixRowCounterCacheToQuestions < ActiveRecord::Migration[6.1]
  def change
    add_column :decidim_forms_questions, :matrix_rows_count, :integer, null: false, default: 0

    reversible do |dir|
      dir.up do
        Decidim::Forms::Question.reset_column_information
        Decidim::Forms::Question.find_each do |record|
          record.class.reset_counters(record.id, :matrix_rows)
        end
      end
    end
  end
end
