# frozen_string_literal: true
# This migration comes from decidim_budgets (originally 20200717140012)

class AddScopeToBudgets < ActiveRecord::Migration[5.2]
  def change
    add_reference :decidim_budgets_budgets, :decidim_scope, foreign_key: true, index: true
  end
end
