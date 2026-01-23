# frozen_string_literal: true

# This migration comes from decidim_assemblies (originally 20240822161222)
class AddDeletedAtToDecidimAssemblies < ActiveRecord::Migration[7.0]
  def change
    add_column :decidim_assemblies, :deleted_at, :datetime
    add_index :decidim_assemblies, :deleted_at
  end
end
