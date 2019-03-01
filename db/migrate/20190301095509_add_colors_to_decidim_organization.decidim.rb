# frozen_string_literal: true
# This migration comes from decidim (originally 20190220023422)

class AddColorsToDecidimOrganization < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_organizations, :colors, :jsonb, default: {}
  end
end
