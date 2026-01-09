# frozen_string_literal: true

# This migration comes from decidim_initiatives (originally 20171017090551)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:13 UTC
class CreateDecidimInitiativesDecidimInitiativesTypeScopes < ActiveRecord::Migration[5.1]
  def change
    create_table :decidim_initiatives_type_scopes do |t|
      t.references :decidim_initiatives_types, index: { name: "idx_scoped_initiative_type_type" }
      t.references :decidim_scopes, index: { name: "idx_scoped_initiative_type_scope" }
      t.integer :supports_required, null: false

      t.timestamps
    end
  end
end
