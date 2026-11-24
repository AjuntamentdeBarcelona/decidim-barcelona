# frozen_string_literal: true

# This migration comes from decidim_forms (originally 20240402092039)
# This file has been modified by `decidim upgrade:migrations` task on 2026-11-24 10:30:18 UTC
class AddAnswerOptionsCounterCacheToQuestions < ActiveRecord::Migration[6.1]
  class Question < ApplicationRecord
    self.table_name = "decidim_forms_questions"

    has_many :answer_options, class_name: "AnswerOption", foreign_key: "decidim_question_id"
  end

  class AnswerOption < ApplicationRecord
    self.table_name = "decidim_forms_answer_options"

    belongs_to :question, class_name: "Question", foreign_key: "decidim_question_id", counter_cache: :answer_options_count
  end

  def change
    add_column :decidim_forms_questions, :answer_options_count, :integer, null: false, default: 0

    reversible do |dir|
      dir.up do
        Question.reset_column_information
        Question.find_each do |record|
          record.class.reset_counters(record.id, :answer_options)
        end
      end
    end
  end
end
