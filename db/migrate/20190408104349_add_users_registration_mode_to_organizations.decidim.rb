# frozen_string_literal: true
# This migration comes from decidim (originally 20181108131058)

class AddUsersRegistrationModeToOrganizations < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_organizations, :users_registration_mode, :integer, default: 0, null: false
  end
end
