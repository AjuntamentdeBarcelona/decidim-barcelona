# frozen_string_literal: true
# This migration comes from decidim_kids (originally 20221017110422)

class CreateOrganizationMinorsConfigs < ActiveRecord::Migration[5.2]
  def change
    create_table :decidim_kids_organization_configs do |t|
      t.integer :decidim_organization_id, null: false, index: { name: "index_decidim_kids_organization" }
      t.boolean :enable_minors_participation, null: false, default: false
      t.integer :minimum_minor_age, null: false, default: 10
      t.integer :maximum_minor_age, null: false, default: 13
      t.string :minors_authorization
      t.string :tutors_authorization
      t.integer :maximum_minor_accounts, null: false, default: 3
      t.timestamps
    end
  end
end
