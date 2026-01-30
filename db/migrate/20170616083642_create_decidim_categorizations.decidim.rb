# frozen_string_literal: true

# This migration comes from decidim (originally 20170612100253)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:12 UTC
class CreateDecidimCategorizations < ActiveRecord::Migration[5.1]
  def change
    create_table :decidim_categorizations do |t|
      t.references :decidim_category, foreign_key: true, null: false
      t.references :categorizable, polymorphic: true, null: false, index: { name: "decidim_categorizations_categorizable_id_and_type" }

      t.timestamps
    end
  end
end
