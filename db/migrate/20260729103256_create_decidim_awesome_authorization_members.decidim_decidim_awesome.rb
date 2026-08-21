# frozen_string_literal: true

# This migration comes from decidim_decidim_awesome (originally 20260630160001)
class CreateDecidimAwesomeAuthorizationMembers < ActiveRecord::Migration[6.0]
  def change
    create_table :decidim_awesome_authorization_members do |t|
      t.string :email, null: false
      t.references :authorization_group, null: false, foreign_key: { to_table: :decidim_awesome_authorization_groups },
                                         index: { name: "decidim_awesome_authorization_members_authorization_group_id" }

      t.timestamps
    end

    add_index :decidim_awesome_authorization_members, [:authorization_group_id, :email], name: "index_auth_members_group_email", unique: true
  end
end
