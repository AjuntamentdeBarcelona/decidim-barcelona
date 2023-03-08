# frozen_string_literal: true
# This migration comes from decidim_kids (originally 20221127103636)

class CreateImpersonationMinorLogs < ActiveRecord::Migration[6.1]
  def change
    create_table :decidim_kids_impersonation_minor_logs do |t|
      t.references :decidim_tutor, index: true
      t.references :decidim_minor, index: true
      t.datetime :started_at
      t.datetime :ended_at
      t.datetime :expired_at

      t.timestamps
    end
  end
end
