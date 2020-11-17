# frozen_string_literal: true
# This migration comes from decidim_assemblies (originally 20200320105907)

class IndexForeignKeysInDecidimAssemblyUserRoles < ActiveRecord::Migration[5.2]
  def change
    add_index :decidim_assembly_user_roles, :decidim_user_id
  end
end
