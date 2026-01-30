# frozen_string_literal: true

# This migration comes from decidim_accountability (originally 20170426104125)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:12 UTC
class CreateAccountabilityResults < ActiveRecord::Migration[5.0]
  def change
    create_table :decidim_accountability_results do |t|
      t.jsonb :title
      t.jsonb :description
      t.string :reference
      t.date :start_date
      t.date :end_date
      t.decimal :progress, precision: 5, scale: 2
      t.references :parent, index: { name: :decidim_accountability_results_on_parent_id }
      t.references :decidim_accountability_status, index: { name: :decidim_accountability_results_on_status_id }
      t.references :decidim_feature, index: true
      t.references :decidim_scope, index: true
      t.references :decidim_category, index: true

      t.timestamps
    end
  end
end
