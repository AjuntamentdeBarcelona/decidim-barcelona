# frozen_string_literal: true

# This migration comes from decidim_participatory_processes (originally 20241108141605)
class RemoveColumnShowStatisticsFromParticipatoryProcesses < ActiveRecord::Migration[7.0]
  def change
    remove_column :decidim_participatory_processes, :show_statistics, :string
  end
end
