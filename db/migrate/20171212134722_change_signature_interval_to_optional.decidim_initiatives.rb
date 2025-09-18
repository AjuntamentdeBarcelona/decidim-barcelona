# frozen_string_literal: true

# This migration comes from decidim_initiatives (originally 20170927153744)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:13 UTC
class ChangeSignatureIntervalToOptional < ActiveRecord::Migration[5.1]
  def change
    change_column :decidim_initiatives, :signature_start_time, :date, null: true
    change_column :decidim_initiatives, :signature_end_time, :date, null: true
  end
end
