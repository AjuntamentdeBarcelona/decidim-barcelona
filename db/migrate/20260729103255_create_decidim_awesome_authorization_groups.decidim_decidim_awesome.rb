# frozen_string_literal: true

# This migration comes from decidim_decidim_awesome (originally 20260630160000)
class CreateDecidimAwesomeAuthorizationGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :decidim_awesome_authorization_groups do |t|
      t.references :decidim_organization, null: false, foreign_key: { to_table: :decidim_organizations }, index: { name: "decidim_awesome_authorization_groups_organization_id" }
      t.jsonb :name, null: false, default: {}
      t.jsonb :purpose, null: false, default: {}

      t.timestamps
    end
  end
end
