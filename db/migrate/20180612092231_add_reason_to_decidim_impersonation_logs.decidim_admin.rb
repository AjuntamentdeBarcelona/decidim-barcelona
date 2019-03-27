# This migration comes from decidim_admin (originally 20180413233318)
# frozen_string_literal: true

class AddReasonToDecidimImpersonationLogs < ActiveRecord::Migration[5.1]
  def change
    add_column :decidim_impersonation_logs, :reason, :text
  end
end
