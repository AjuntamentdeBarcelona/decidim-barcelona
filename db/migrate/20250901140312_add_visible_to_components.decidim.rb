# frozen_string_literal: true

# This migration comes from decidim (originally 20240628111905)
class AddVisibleToComponents < ActiveRecord::Migration[7.0]
  def change
    add_column :decidim_components, :visible, :boolean, default: true
  end
end
