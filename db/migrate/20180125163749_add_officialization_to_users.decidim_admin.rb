# frozen_string_literal: true

# This migration comes from decidim_admin (originally 20171219154507)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:12 UTC
class AddOfficializationToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :decidim_users, :officialized_at, :datetime
    add_column :decidim_users, :officialized_as, :jsonb

    add_index :decidim_users, :officialized_at
  end
end
