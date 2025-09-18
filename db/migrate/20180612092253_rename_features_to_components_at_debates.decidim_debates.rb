# frozen_string_literal: true

# This migration comes from decidim_debates (originally 20180305133556)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:13 UTC
class RenameFeaturesToComponentsAtDebates < ActiveRecord::Migration[5.1]
  def change
    rename_column :decidim_debates_debates, :decidim_feature_id, :decidim_component_id

    if index_name_exists?(:decidim_debates_debates, "index_decidim_debates_debates_on_decidim_feature_id")
      rename_index :decidim_debates_debates, "index_decidim_debates_debates_on_decidim_feature_id", "index_decidim_debates_debates_on_decidim_component_id"
    end
  end
end
