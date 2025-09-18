# frozen_string_literal: true

# This migration comes from decidim_budgets (originally 20170612101846)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:12 UTC
class MigrateProjectsCategory < ActiveRecord::Migration[5.1]
  def change
    # Create categorizations ensuring database integrity
    execute('
      INSERT INTO decidim_categorizations(decidim_category_id, categorizable_id, categorizable_type, created_at, updated_at)
        SELECT decidim_category_id, decidim_budgets_projects.id, \'Decidim::Budgets::Project\', NOW(), NOW()
        FROM decidim_budgets_projects
        INNER JOIN decidim_categories ON decidim_categories.id = decidim_budgets_projects.decidim_category_id
    ')
    # Remove unused column
    remove_column :decidim_budgets_projects, :decidim_category_id
  end
end
