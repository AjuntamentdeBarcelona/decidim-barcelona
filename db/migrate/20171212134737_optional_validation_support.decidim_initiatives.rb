# frozen_string_literal: true

# This migration comes from decidim_initiatives (originally 20171023141639)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:13 UTC
class OptionalValidationSupport < ActiveRecord::Migration[5.1]
  def change
    add_column :decidim_initiatives_types,
               :requires_validation, :boolean, null: false, default: true
  end
end
