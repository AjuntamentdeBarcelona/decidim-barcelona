# frozen_string_literal: true
# This migration comes from decidim (originally 20200107142226)

class AddOrganizationTimezone < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_organizations, :time_zone, :string, limit: 255, default: "UTC"
  end
end
