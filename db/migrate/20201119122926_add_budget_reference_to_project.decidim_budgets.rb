# frozen_string_literal: true
# This migration comes from decidim_budgets (originally 20200629134013)

class AddBudgetReferenceToProject < ActiveRecord::Migration[5.2]
  def change
    add_reference :decidim_budgets_projects, :decidim_budgets_budget, foreign_key: true
  end
end
