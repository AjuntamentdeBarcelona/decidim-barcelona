# frozen_string_literal: true

# This migration comes from decidim (originally 20171011194251)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:12 UTC
class AddVerificationMetadataToAuthorizations < ActiveRecord::Migration[5.1]
  def up
    add_column :decidim_authorizations, :verification_metadata, :jsonb, default: {}
  end

  def down
    remove_column :decidim_authorizations, :verification_metadata
  end
end
