# frozen_string_literal: true

# This migration comes from decidim_admin (originally 20180413233318)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:12 UTC
class AddReasonToDecidimImpersonationLogs < ActiveRecord::Migration[5.1]
  def change
    add_column :decidim_impersonation_logs, :reason, :text
  end
end
