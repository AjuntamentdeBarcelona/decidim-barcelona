# frozen_string_literal: true

# This migration comes from decidim_forms (originally 20170515144119)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:13 UTC
class CreateDecidimFormsAnswers < ActiveRecord::Migration[5.0]
  def change
    create_table :decidim_forms_answers do |t|
      t.text :body
      t.references :decidim_user, index: true
      t.references :decidim_questionnaire, index: true
      t.references :decidim_question, index: { name: "index_decidim_forms_answers_question_id" }

      t.timestamps
    end
  end
end
