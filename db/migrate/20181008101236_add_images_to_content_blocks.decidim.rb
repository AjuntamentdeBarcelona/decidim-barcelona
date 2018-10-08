# frozen_string_literal: true
# This migration comes from decidim (originally 20180808135006)

class AddImagesToContentBlocks < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_content_blocks, :images, :jsonb, default: {}
  end
end
