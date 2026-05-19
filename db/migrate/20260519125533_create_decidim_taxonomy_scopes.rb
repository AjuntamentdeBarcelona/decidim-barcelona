# frozen_string_literal: true

class CreateDecidimTaxonomyScopes < ActiveRecord::Migration[7.0]
  def up
    create_table :decidim_taxonomy_scopes do |t|
      t.references :taxonomy,
                   null: false,
                   index: { unique: true },
                   foreign_key: { to_table: :decidim_taxonomies }
      t.bigint :scope_id, null: false
      t.string :scope_code

      t.timestamps
    end

    add_index :decidim_taxonomy_scopes, :scope_id, unique: true

    # Backfill from decidim_scopes via raw SQL. We match a scope to a taxonomy
    # by Catalan name within the same organization. We never reference the
    # Decidim::Scope class from runtime code; this migration touches the
    # `decidim_scopes` table directly via SQL.
    execute <<~SQL.squish
      INSERT INTO decidim_taxonomy_scopes (taxonomy_id, scope_id, scope_code, created_at, updated_at)
      SELECT DISTINCT ON (t.id)
             t.id,
             s.id,
             s.code,
             NOW(),
             NOW()
      FROM decidim_taxonomies t
      INNER JOIN decidim_scopes s
        ON s.decidim_organization_id = t.decidim_organization_id
       AND (s.name ->> 'ca') = (t.name ->> 'ca')
      ORDER BY t.id, s.id
      ON CONFLICT DO NOTHING
    SQL
  end

  def down
    drop_table :decidim_taxonomy_scopes
  end
end
