# frozen_string_literal: true

# This migration comes from decidim_debates (originally 20241017153555)
class AddCommentsLayoutToDebates < ActiveRecord::Migration[7.0]
  def change
    add_column :decidim_debates_debates, :comments_layout, :string
  end
end
