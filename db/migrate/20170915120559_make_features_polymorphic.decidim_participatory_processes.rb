# frozen_string_literal: true

# This migration comes from decidim_participatory_processes (originally 20170720120135)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:13 UTC
class MakeFeaturesPolymorphic < ActiveRecord::Migration[5.1]
  def change
    remove_index :decidim_components, name: "index_decidim_components_on_decidim_participatory_process_id"

    add_column :decidim_components, :participatory_space_type, :string

    reversible do |direction|
      direction.up do
        execute <<~SQL.squish
          UPDATE decidim_components
          SET participatory_space_type = 'Decidim::ParticipatoryProcess'
        SQL
      end
    end

    rename_column :decidim_components, :decidim_participatory_process_id, :participatory_space_id

    add_index :decidim_components,
              [:participatory_space_id, :participatory_space_type],
              name: "index_decidim_components_on_decidim_participatory_space"

    change_column_null :decidim_components, :participatory_space_id, false
    change_column_null :decidim_components, :participatory_space_type, false
  end
end
