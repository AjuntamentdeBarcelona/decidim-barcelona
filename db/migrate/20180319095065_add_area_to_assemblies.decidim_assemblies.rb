# frozen_string_literal: true

# This migration comes from decidim_assemblies (originally 20180216091553)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:12 UTC
class AddAreaToAssemblies < ActiveRecord::Migration[5.1]
  def change
    add_reference :decidim_assemblies, :decidim_area, index: true
  end
end
