# frozen_string_literal: true

# This migration comes from decidim (originally 20180123125409)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:12 UTC
class AddOmnipresentBannerTitleToDecidimOrganizations < ActiveRecord::Migration[5.1]
  def change
    add_column :decidim_organizations, :omnipresent_banner_title, :jsonb
  end
end
