# frozen_string_literal: true
# This migration comes from decidim (originally 20190325145349)

class AddExtendedDataToNewsletters < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_newsletters, :extended_data, :jsonb, default: {}
  end
end
