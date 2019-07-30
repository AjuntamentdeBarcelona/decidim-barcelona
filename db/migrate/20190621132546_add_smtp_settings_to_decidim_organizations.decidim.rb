# frozen_string_literal: true
# This migration comes from decidim (originally 20181219130325)

class AddSmtpSettingsToDecidimOrganizations < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_organizations, :smtp_settings, :jsonb
  end
end
