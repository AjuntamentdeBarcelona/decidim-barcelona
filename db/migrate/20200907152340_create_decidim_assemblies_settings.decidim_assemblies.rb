# frozen_string_literal: true
# This migration comes from decidim_assemblies (originally 20200430202456)

class CreateDecidimAssembliesSettings < ActiveRecord::Migration[5.2]
  def change
    create_table :decidim_assemblies_settings do |t|
      t.boolean :enable_organization_chart, default: true
      t.references :decidim_organization, foreign_key: true
    end
  end
end
