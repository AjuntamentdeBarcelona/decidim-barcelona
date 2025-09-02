# frozen_string_literal: true

# This migration comes from decidim_meetings (originally 20170612101925)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:13 UTC
class MigrateMeetingsCategory < ActiveRecord::Migration[5.1]
  def change
    # Create categorizations ensuring database integrity
    execute('
      INSERT INTO decidim_categorizations(decidim_category_id, categorizable_id, categorizable_type, created_at, updated_at)
        SELECT decidim_category_id, decidim_meetings_meetings.id, \'Decidim::Meetings::Meeting\', NOW(), NOW()
        FROM decidim_meetings_meetings
        INNER JOIN decidim_categories ON decidim_categories.id = decidim_meetings_meetings.decidim_category_id
    ')
    # Remove unused column
    remove_column :decidim_meetings_meetings, :decidim_category_id
  end
end
