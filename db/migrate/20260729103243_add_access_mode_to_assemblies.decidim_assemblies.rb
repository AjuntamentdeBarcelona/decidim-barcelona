# frozen_string_literal: true

# This migration comes from decidim_assemblies (originally 20260111120000)
class AddAccessModeToAssemblies < ActiveRecord::Migration[6.1]
  def up
    add_column :decidim_assemblies, :access_mode, :integer, null: false, default: 0
  end

  def down
    remove_column :decidim_assemblies, :access_mode
  end
end
