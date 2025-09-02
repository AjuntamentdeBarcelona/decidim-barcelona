# frozen_string_literal: true

# This migration comes from decidim (originally 20170206083118)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:13 UTC
class RenameExtraInfoOnProcesses < ActiveRecord::Migration[5.0]
  def change
    remove_column :decidim_participatory_processes, :developer_group

    rename_column :decidim_participatory_processes, :domain, :developer_group

    add_column :decidim_participatory_processes, :local_area, :jsonb
    add_column :decidim_participatory_processes, :target, :jsonb
    add_column :decidim_participatory_processes, :participatory_scope, :jsonb
    add_column :decidim_participatory_processes, :participatory_structure, :jsonb
  end
end
