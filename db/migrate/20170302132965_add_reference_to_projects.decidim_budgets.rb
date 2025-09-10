# frozen_string_literal: true

# This migration comes from decidim_budgets (originally 20170215132708)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:12 UTC
class AddReferenceToProjects < ActiveRecord::Migration[5.0]
  class Project < ApplicationRecord
    self.table_name = :decidim_budgets_projects
  end

  def change
    add_column :decidim_budgets_projects, :reference, :string
    Project.find_each(&:save)
    change_column_null :decidim_budgets_projects, :reference, false
  end
end
