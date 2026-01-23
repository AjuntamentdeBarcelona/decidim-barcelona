# frozen_string_literal: true

# This migration comes from decidim_participatory_processes (originally 20200204154917)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:13 UTC
class AddShowMetricsToParticipatoryProcesses < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_participatory_processes, :show_metrics, :boolean, default: true
  end
end
