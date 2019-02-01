# frozen_string_literal: true
# This migration comes from decidim_budgets (originally 20181205141115)

class UseBigIntsForBudgets < ActiveRecord::Migration[5.2]
  def change
    change_column :decidim_budgets_projects, :budget, :bigint
  end
end
