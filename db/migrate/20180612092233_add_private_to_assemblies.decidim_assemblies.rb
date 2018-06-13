# This migration comes from decidim_assemblies (originally 20180124083729)
# frozen_string_literal: true

class AddPrivateToAssemblies < ActiveRecord::Migration[5.1]
  def change
    add_column :decidim_assemblies, :private_space, :boolean, default: false
  end
end
