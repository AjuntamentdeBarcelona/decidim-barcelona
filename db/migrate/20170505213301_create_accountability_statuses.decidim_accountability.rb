# frozen_string_literal: true

# This migration comes from decidim_accountability (originally 20170425154712)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:12 UTC
class CreateAccountabilityStatuses < ActiveRecord::Migration[5.0]
  def change
    create_table :decidim_accountability_statuses do |t|
      t.string :key
      t.jsonb :name
      t.references :decidim_feature, index: true

      t.timestamps
    end
  end
end
