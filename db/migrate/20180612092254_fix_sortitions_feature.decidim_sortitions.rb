# frozen_string_literal: true

# This migration comes from decidim_sortitions (originally 20180322082150)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:13 UTC
class FixSortitionsFeature < ActiveRecord::Migration[5.1]
  def up
    rename_column :decidim_sortitions_sortitions, :decidim_feature_id, :decidim_component_id
  end

  def down
    rename_column :decidim_sortitions_sortitions, :decidim_component_id, :decidim_feature_id
  end
end
