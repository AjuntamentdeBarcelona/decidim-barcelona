# frozen_string_literal: true
# This migration comes from decidim_initiatives (originally 20200514085422)

class AddAreaToInitiatives < ActiveRecord::Migration[5.2]
  def change
    add_reference :decidim_initiatives, :decidim_area, index: true
  end
end
