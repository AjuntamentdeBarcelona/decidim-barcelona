# frozen_string_literal: true

# This migration comes from decidim_debates (originally 20251114092453)
class RemoveLegacyImagesFromDebatesModule < ActiveRecord::Migration[7.2]
  def change
    remove_column :decidim_debates_debates, :image, :string
  end
end
