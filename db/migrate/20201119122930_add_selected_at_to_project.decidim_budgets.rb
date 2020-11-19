# frozen_string_literal: true
# This migration comes from decidim_budgets (originally 20200728075039)

class AddSelectedAtToProject < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_budgets_projects, :selected_at, :date, index: true
  end
end
