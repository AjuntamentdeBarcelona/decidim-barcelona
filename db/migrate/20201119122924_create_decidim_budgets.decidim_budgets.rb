# frozen_string_literal: true

# This migration comes from decidim_budgets (originally 20200617105120)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:12 UTC
class CreateDecidimBudgets < ActiveRecord::Migration[5.0]
  def change
    create_table :decidim_budgets_budgets do |t|
      t.jsonb :title
      t.integer :weight, null: false, default: 0
      t.jsonb :description
      t.integer :total_budget, default: 0
      t.references :decidim_component, index: true

      t.timestamps
    end
  end
end
