# frozen_string_literal: true

# This migration comes from decidim (originally 20190610093742)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:12 UTC
class AddForceUsersToAuthenticateBeforeAccessOrganization < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_organizations,
               :force_users_to_authenticate_before_access_organization,
               :boolean,
               default: false
  end
end
