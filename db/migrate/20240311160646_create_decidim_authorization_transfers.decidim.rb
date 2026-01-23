# frozen_string_literal: true

# This migration comes from decidim (originally 20220629194812)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:13 UTC
class CreateDecidimAuthorizationTransfers < ActiveRecord::Migration[6.1]
  def change
    create_table :decidim_authorization_transfers do |t|
      t.references :user, null: false, foreign_key: { to_table: :decidim_users }, index: true
      t.references :source_user, null: false, foreign_key: { to_table: :decidim_users }, index: true
      t.references :authorization, null: false, foreign_key: { to_table: :decidim_authorizations }, index: true

      t.datetime :created_at, null: false
    end

    create_table :decidim_authorization_transfer_records do |t|
      t.references :transfer, null: false, foreign_key: { to_table: :decidim_authorization_transfers }, index: true
      t.references :resource, polymorphic: true, null: false

      t.datetime :created_at, null: false
    end
  end
end
