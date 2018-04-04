# This migration comes from decidim_assemblies (originally 20180216091553)
# frozen_string_literal: true

class AddAreaToAssemblies < ActiveRecord::Migration[5.1]
  def change
    add_reference :decidim_assemblies, :decidim_area, index: true
  end
end
