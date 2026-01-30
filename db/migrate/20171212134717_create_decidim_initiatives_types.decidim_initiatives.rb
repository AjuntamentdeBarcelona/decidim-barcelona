# frozen_string_literal: true

# This migration comes from decidim_initiatives (originally 20170906091626)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:13 UTC
class CreateDecidimInitiativesTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :decidim_initiatives_types do |t|
      t.jsonb :title, null: false
      t.jsonb :description, null: false
      t.integer :supports_required, null: false

      t.integer :decidim_organization_id,
                foreign_key: true,
                index: {
                  name: "index_decidim_initiative_types_on_decidim_organization_id"
                }

      t.timestamps
    end
  end
end
