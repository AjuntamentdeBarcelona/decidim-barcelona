# frozen_string_literal: true

# This migration comes from decidim_assemblies (originally 20210310120444)
# This file has been modified by `decidim upgrade:migrations` task on 2026-07-29 10:32:27 UTC
class AddFollowableCounterCacheToAssemblies < ActiveRecord::Migration[5.2]
  class Assembly < ApplicationRecord
    self.table_name = :decidim_assemblies
  end

  def change
    add_column :decidim_assemblies, :follows_count, :integer, null: false, default: 0, index: true

    reversible do |dir|
      dir.up do
        Assembly.reset_column_information
        Assembly.unscoped.find_each do |record|
          record.class.reset_counters(record.id, :follows)
        end
      end
    end
  end
end
