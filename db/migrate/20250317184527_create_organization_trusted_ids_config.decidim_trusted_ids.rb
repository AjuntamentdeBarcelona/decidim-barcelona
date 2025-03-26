# frozen_string_literal: true

# This migration comes from decidim_trusted_ids (originally 20230718082548)
class CreateOrganizationTrustedIdsConfig < ActiveRecord::Migration[6.0]
  def change
    create_table :organization_trusted_ids_configs do |t|
      t.integer :decidim_organization_id, null: false, index: { name: "index_decidim_trusted_ids_organization" }
      t.string :handler
      t.jsonb :settings, null: false, default: {}
      t.integer :expiration_days
      t.jsonb :tos, null: false, default: {}
      t.timestamps
    end
  end
end
