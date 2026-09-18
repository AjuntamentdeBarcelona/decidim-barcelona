# frozen_string_literal: true

# This migration comes from decidim_initiatives (originally 20251112114520)
class RemoveLegacyImagesFromInitiativesModule < ActiveRecord::Migration[7.2]
  def change
    remove_column :decidim_initiatives_types, :banner_image, :string
  end
end
