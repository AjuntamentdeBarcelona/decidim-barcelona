# frozen_string_literal: true

# This migration comes from decidim_assemblies (originally 20251205120000)
class AddHasMembersToDecidimAssemblies < ActiveRecord::Migration[7.0]
  def change
    add_column :decidim_assemblies, :has_members, :boolean, default: false
  end
end
