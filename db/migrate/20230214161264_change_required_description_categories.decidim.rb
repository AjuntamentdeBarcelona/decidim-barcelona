# frozen_string_literal: true
# This migration comes from decidim (originally 20220118121921)

class ChangeRequiredDescriptionCategories < ActiveRecord::Migration[6.0]
  def change
    change_column_null :decidim_categories, :description, true
  end
end
