# frozen_string_literal: true

# This migration comes from decidim_decidim_awesome (originally 20260729114258)
class CreateFollowUpQuestionnaireMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :decidim_awesome_follow_up_questionnaire_messages do |t|
      t.references :follow_up_questionnaire,
                   null: false,
                   foreign_key: { to_table: :decidim_awesome_follow_up_questionnaires },
                   index: { name: "index_fuqm_on_follow_up_questionnaire_id" }
      t.references :decidim_user, index: { name: "index_fuqm_on_decidim_user_id" }
      t.string :session_token, null: true, index: { name: "index_fuqm_on_session_token" }

      t.references :status,
                   null: false,
                   foreign_key: { to_table: :decidim_awesome_follow_up_questionnaire_statuses },
                   index: { name: "index_fuqm_on_status_id" }
      t.text :body
      t.references :author,
                   polymorphic: true,
                   null: false,
                   index: { name: "index_fuqm_on_author" }

      t.timestamps
    end

    add_index :decidim_awesome_follow_up_questionnaire_messages,
              [:follow_up_questionnaire_id, :decidim_user_id, :session_token, :created_at],
              name: "index_fuqm_on_respondent_created_at"
  end
end
