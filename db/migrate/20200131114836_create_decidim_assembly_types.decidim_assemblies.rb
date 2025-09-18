# frozen_string_literal: true

# This migration comes from decidim_assemblies (originally 20200108113855)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:12 UTC
class CreateDecidimAssemblyTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :decidim_assemblies_types do |t|
      t.jsonb :title, null: false

      t.integer :decidim_organization_id,
                foreign_key: true,
                index: {
                  name: "index_decidim_assemblies_types_on_decidim_organization_id"
                }

      t.timestamps
    end

    add_reference :decidim_assemblies, :decidim_assemblies_type, index: true, foreign_key: true
  end
end
