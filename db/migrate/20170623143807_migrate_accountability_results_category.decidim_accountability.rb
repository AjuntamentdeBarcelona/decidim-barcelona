# frozen_string_literal: true

# This migration comes from decidim_accountability (originally 20170623094200)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:12 UTC
class MigrateAccountabilityResultsCategory < ActiveRecord::Migration[5.1]
  def change
    # Create categorizations ensuring database integrity
    execute('
      INSERT INTO decidim_categorizations(decidim_category_id, categorizable_id, categorizable_type, created_at, updated_at)
        SELECT decidim_category_id, decidim_accountability_results.id, \'Decidim::Accountability::Result\', NOW(), NOW()
        FROM decidim_accountability_results
        INNER JOIN decidim_categories ON decidim_categories.id = decidim_accountability_results.decidim_category_id
    ')
    # Remove unused column
    remove_column :decidim_accountability_results, :decidim_category_id
  end
end
