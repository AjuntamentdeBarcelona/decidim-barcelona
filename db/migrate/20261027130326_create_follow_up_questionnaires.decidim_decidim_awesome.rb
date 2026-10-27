# frozen_string_literal: true

# This migration comes from decidim_decidim_awesome (originally 20260729114256)
class CreateFollowUpQuestionnaires < ActiveRecord::Migration[7.0]
  def change
    create_table :decidim_awesome_follow_up_questionnaires do |t|
      t.references :decidim_organization, null: false, foreign_key: { to_table: :decidim_organizations }, index: { name: "index_decidim_awesome_fuq_on_organization_id" }
      t.references :decidim_component, null: false, foreign_key: { to_table: :decidim_components }, index: { name: "index_decidim_awesome_fuq_on_component_id" }
      t.bigint :decidim_questionnaire_id, null: false
      t.jsonb :name, null: false, default: {}
      t.integer :position, null: false, default: 0
      t.string :responder_name_field
      t.string :responder_email_field
      t.string :reply_to
      t.boolean :active, null: false, default: true

      t.timestamps
    end

    add_index :decidim_awesome_follow_up_questionnaires, :decidim_questionnaire_id, unique: true, name: "index_decidim_awesome_fuq_on_questionnaire_id"
    add_index :decidim_awesome_follow_up_questionnaires, [:active, :position], name: "index_decidim_awesome_fuq_on_active_position"
  end
end
