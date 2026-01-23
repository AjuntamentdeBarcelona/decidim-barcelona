# frozen_string_literal: true

# This migration comes from decidim_initiatives (originally 20200417120551)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:13 UTC
class AddCustomSignatureEndTimeOption < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_initiatives_types, :custom_signature_end_date_enabled, :boolean, null: false, default: false
  end
end
