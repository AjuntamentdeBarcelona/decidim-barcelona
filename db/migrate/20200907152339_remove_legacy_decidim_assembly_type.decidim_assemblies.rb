# frozen_string_literal: true

# This migration comes from decidim_assemblies (originally 20200416132109)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:12 UTC
class RemoveLegacyDecidimAssemblyType < ActiveRecord::Migration[5.2]
  def change
    remove_column :decidim_assemblies, :assembly_type, :string
    remove_column :decidim_assemblies, :assembly_type_other, :jsonb
  end
end
