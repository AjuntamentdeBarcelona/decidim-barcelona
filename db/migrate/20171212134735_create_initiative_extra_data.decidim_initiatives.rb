# frozen_string_literal: true

# This migration comes from decidim_initiatives (originally 20171023075942)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:13 UTC
class CreateInitiativeExtraData < ActiveRecord::Migration[5.1]
  def change
    create_table :decidim_initiatives_extra_data do |t|
      t.references :decidim_initiative, null: false, index: true
      t.integer :data_type, null: false, default: 0
      t.jsonb :data, null: false
    end
  end
end
