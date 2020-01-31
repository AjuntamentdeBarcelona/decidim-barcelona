# frozen_string_literal: true
# This migration comes from decidim (originally 20191113092826)

class AddOmniauthSettingsToDecidimOrganization < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_organizations, :omniauth_settings, :jsonb
  end
end
