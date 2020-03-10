# frozen_string_literal: true
# This migration comes from decidim_participatory_processes (originally 20200204154917)

class AddShowMetricsToParticipatoryProcesses < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_participatory_processes, :show_metrics, :boolean, default: true
  end
end
