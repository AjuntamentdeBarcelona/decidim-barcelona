# frozen_string_literal: true
# This migration comes from decidim_assemblies (originally 20210507063604)

class AddAnnouncementToAssemblies < ActiveRecord::Migration[6.0]
  def change
    add_column :decidim_assemblies, :announcement, :jsonb
  end
end
