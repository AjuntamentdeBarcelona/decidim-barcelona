# frozen_string_literal: true

# This migration comes from decidim (originally 20170720140610)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:12 UTC
class SetEmailUniqueInOrganizationConditionForManagedUsers < ActiveRecord::Migration[5.1]
  def change
    remove_index :decidim_users, %w(email decidim_organization_id)
    add_index :decidim_users,
              %w(email decidim_organization_id),
              where: "(deleted_at IS NULL) AND (managed = 'f')",
              name: "index_decidim_users_on_email_and_decidim_organization_id",
              unique: true
  end
end
