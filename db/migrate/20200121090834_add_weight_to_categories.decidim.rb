# frozen_string_literal: true
# This migration comes from decidim (originally 20191118120529)

class AddWeightToCategories < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_categories, :weight, :integer, null: false, default: 0
  end
end
