# frozen_string_literal: true

# This migration comes from decidim (originally 20181008102144)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:12 UTC
class AddBadgeSwitchToOrganizations < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_organizations, :badges_enabled, :boolean, null: false, default: false
    execute "UPDATE decidim_organizations set badges_enabled = true"
  end
end
