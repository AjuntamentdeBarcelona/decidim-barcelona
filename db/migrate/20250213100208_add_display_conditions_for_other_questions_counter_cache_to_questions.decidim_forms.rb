# frozen_string_literal: true

# This migration comes from decidim_forms (originally 20240416113926)
class AddDisplayConditionsForOtherQuestionsCounterCacheToQuestions < ActiveRecord::Migration[6.1]
  def change
    add_column :decidim_forms_questions, :display_conditions_for_other_questions_count, :integer, null: false, default: 0

    reversible do |dir|
      dir.up do
        Decidim::Forms::Question.reset_column_information
        Decidim::Forms::Question.find_each do |record|
          record.class.reset_counters(record.id, :display_conditions_for_other_questions)
        end
      end
    end
  end
end
