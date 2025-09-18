# frozen_string_literal: true

# This migration comes from decidim_participatory_processes (originally 20201008154315)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:13 UTC
class AddMetadataColumnsToParticipatoryProcessGroups < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_participatory_process_groups, :group_url, :string
    add_column :decidim_participatory_process_groups, :developer_group, :jsonb
    add_column :decidim_participatory_process_groups, :local_area, :jsonb
    add_column :decidim_participatory_process_groups, :meta_scope, :jsonb
    add_column :decidim_participatory_process_groups, :target, :jsonb
    add_column :decidim_participatory_process_groups, :participatory_scope, :jsonb
    add_column :decidim_participatory_process_groups, :participatory_structure, :jsonb
  end
end
