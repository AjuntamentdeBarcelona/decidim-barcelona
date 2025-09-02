# frozen_string_literal: true

# This migration comes from decidim (originally 20170207091021)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:12 UTC
class AddSocialMediaHandlersToOrganization < ActiveRecord::Migration[5.0]
  def change
    add_column :decidim_organizations, :instagram_handler, :string
    add_column :decidim_organizations, :facebook_handler, :string
    add_column :decidim_organizations, :youtube_handler, :string
    add_column :decidim_organizations, :github_handler, :string
  end
end
