# frozen_string_literal: true
# This migration comes from decidim_forms (originally 20170515090916)

class CreateDecidimFormsQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :decidim_forms_questions do |t|
      t.references :decidim_questionnaire, index: true
      t.integer :position, index: true
      t.string :question_type
      t.boolean :mandatory
      t.jsonb :body
      t.jsonb :description
      t.integer :max_choices

      t.timestamps
    end
  end
end
