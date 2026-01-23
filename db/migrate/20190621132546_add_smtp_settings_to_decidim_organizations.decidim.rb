# frozen_string_literal: true

# This migration comes from decidim (originally 20181219130325)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:12 UTC
class AddSmtpSettingsToDecidimOrganizations < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_organizations, :smtp_settings, :jsonb
  end
end
