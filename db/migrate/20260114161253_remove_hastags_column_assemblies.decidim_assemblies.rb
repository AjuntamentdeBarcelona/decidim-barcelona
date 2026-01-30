# frozen_string_literal: true

# This migration comes from decidim_assemblies (originally 20250604081741)
class RemoveHastagsColumnAssemblies < ActiveRecord::Migration[7.1]
  def change
    remove_column :decidim_assemblies, :hashtag, :string, if_exists: true
  end
end
