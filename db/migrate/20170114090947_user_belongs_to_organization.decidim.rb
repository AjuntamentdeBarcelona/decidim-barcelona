# frozen_string_literal: true

# This migration comes from decidim (originally 20160920141039)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:12 UTC
class UserBelongsToOrganization < ActiveRecord::Migration[5.0]
  def change
    add_reference :decidim_users, :decidim_organization, index: true, foreign_key: true
  end
end
