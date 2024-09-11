# frozen_string_literal: true
# This migration comes from decidim_reporting_proposals (originally 20221219151846)

class CreateDecidimCategoriesValuators < ActiveRecord::Migration[6.0]
  def change
    create_table :decidim_reporting_proposals_category_valuators do |t|
      t.references :decidim_category, null: false, foreign_key: { to_table: "decidim_categories" }, index: { name: "decidim_reporting_proposals_category_category_id" }
      t.references :valuator_role, polymorphic: true, null: false, index: { name: "decidim_reporting_proposals_category_valuator_role" }

      t.timestamps
    end

    add_index :decidim_reporting_proposals_category_valuators,
              [:decidim_category_id, :valuator_role_id, :valuator_role_type],
              unique: true,
              name: "decidim_reporting_proposals_category_valuator_unique"
  end
end
