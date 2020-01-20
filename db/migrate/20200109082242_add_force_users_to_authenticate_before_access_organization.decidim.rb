# frozen_string_literal: true
# This migration comes from decidim (originally 20190610093742)

class AddForceUsersToAuthenticateBeforeAccessOrganization < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_organizations,
               :force_users_to_authenticate_before_access_organization,
               :boolean,
               default: false
  end
end
