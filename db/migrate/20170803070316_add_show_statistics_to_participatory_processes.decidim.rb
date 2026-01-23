# frozen_string_literal: true

# This migration comes from decidim (originally 20170725085104)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:13 UTC
class AddShowStatisticsToParticipatoryProcesses < ActiveRecord::Migration[5.1]
  def change
    add_column :decidim_participatory_processes, :show_statistics, :boolean, default: true
  end
end
