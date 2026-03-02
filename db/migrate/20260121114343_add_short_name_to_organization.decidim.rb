# frozen_string_literal: true

# This migration comes from decidim (originally 20251031150928)
class AddShortNameToOrganization < ActiveRecord::Migration[7.2]
  def change
    add_column :decidim_organizations, :short_name, :jsonb, null: false, default: {}
  end
end
