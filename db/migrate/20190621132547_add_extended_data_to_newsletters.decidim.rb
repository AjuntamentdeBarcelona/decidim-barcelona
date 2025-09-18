# frozen_string_literal: true

# This migration comes from decidim (originally 20190325145349)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:12 UTC
class AddExtendedDataToNewsletters < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_newsletters, :extended_data, :jsonb, default: {}
  end
end
