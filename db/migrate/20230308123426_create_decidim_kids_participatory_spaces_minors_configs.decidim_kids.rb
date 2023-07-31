# frozen_string_literal: true
# This migration comes from decidim_kids (originally 20221220132306)

class CreateDecidimKidsParticipatorySpacesMinorsConfigs < ActiveRecord::Migration[6.1]
  def change
    create_table :decidim_kids_participatory_spaces_minors_configs do |t|
      t.string :access_type, null: false, default: "all"
      t.string :authorization
      t.integer :max_age, null: false, default: 16
      t.references :participatory_space, polymorphic: true, index: { name: "index_minor_config_on_space_type_and_id" }
      t.timestamps
    end
  end
end
