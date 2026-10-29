# frozen_string_literal: true

# This migration comes from decidim_decidim_awesome (originally 20260729114257)
class CreateFollowUpQuestionnaireStatuses < ActiveRecord::Migration[7.0]
  def change
    create_table :decidim_awesome_follow_up_questionnaire_statuses do |t|
      t.references :follow_up_questionnaire,
                   null: false,
                   foreign_key: { to_table: :decidim_awesome_follow_up_questionnaires },
                   index: { name: "index_fuqs_on_follow_up_questionnaire_id" }

      t.jsonb :name, null: false, default: {}
      t.string :color, null: false
      t.timestamps
    end
  end
end
