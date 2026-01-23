# frozen_string_literal: true

# This migration comes from decidim (originally 20170724130558)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:12 UTC
class CreateImpersonationLogs < ActiveRecord::Migration[5.1]
  def change
    create_table :decidim_impersonation_logs do |t|
      t.references :decidim_admin, index: true
      t.references :decidim_user, index: true
      t.datetime :started_at
      t.datetime :ended_at
      t.datetime :expired_at

      t.timestamps
    end
  end
end
