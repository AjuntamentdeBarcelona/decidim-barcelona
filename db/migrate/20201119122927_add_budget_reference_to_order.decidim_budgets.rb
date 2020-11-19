# frozen_string_literal: true
# This migration comes from decidim_budgets (originally 20200706142609)

class AddBudgetReferenceToOrder < ActiveRecord::Migration[5.2]
  def change
    add_reference :decidim_budgets_orders, :decidim_budgets_budget, foreign_key: true
  end
end
