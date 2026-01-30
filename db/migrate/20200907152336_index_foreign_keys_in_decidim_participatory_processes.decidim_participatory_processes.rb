# frozen_string_literal: true

# This migration comes from decidim_participatory_processes (originally 20200320105925)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:13 UTC
class IndexForeignKeysInDecidimParticipatoryProcesses < ActiveRecord::Migration[5.2]
  def change
    add_index :decidim_participatory_processes, :decidim_participatory_process_group_id, name: "idx_process_on_process_group_id"
    add_index :decidim_participatory_processes, :decidim_scope_id, name: "idx_process_on_scope_id"
  end
end
