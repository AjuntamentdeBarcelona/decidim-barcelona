# frozen_string_literal: true

# This migration comes from decidim_participatory_processes (originally 20210310120750)
# This file has been modified by `decidim upgrade:migrations` task on 2026-07-29 10:32:30 UTC
class AddFollowableCounterCacheToParticipatoryProcesses < ActiveRecord::Migration[5.2]
  class ParticipatoryProcess < ApplicationRecord
    self.table_name = :decidim_participatory_processes
  end

  def change
    add_column :decidim_participatory_processes, :follows_count, :integer, null: false, default: 0, index: true

    reversible do |dir|
      dir.up do
        ParticipatoryProcess.reset_column_information
        ParticipatoryProcess.unscoped.find_each do |record|
          record.class.reset_counters(record.id, :follows)
        end
      end
    end
  end
end
