# frozen_string_literal: true

# This migration comes from decidim (originally 20180125063433)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:12 UTC
class AddHighlightedContentBannerToDecidimOrganizations < ActiveRecord::Migration[5.1]
  def change
    add_column :decidim_organizations, :highlighted_content_banner_enabled, :boolean, null: false, default: false
    add_column :decidim_organizations, :highlighted_content_banner_title, :jsonb
    add_column :decidim_organizations, :highlighted_content_banner_short_description, :jsonb
    add_column :decidim_organizations, :highlighted_content_banner_action_title, :jsonb
    add_column :decidim_organizations, :highlighted_content_banner_action_subtitle, :jsonb
    add_column :decidim_organizations, :highlighted_content_banner_action_url, :string
    add_column :decidim_organizations, :highlighted_content_banner_image, :string
  end
end
