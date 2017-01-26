# This migration comes from decidim_debates (originally 20170118141619)
class CreateDebates < ActiveRecord::Migration[5.0]
  def change
    create_table :decidim_debates_debates do |t|
      t.jsonb :title
      t.jsonb :description
      t.datetime :start_time
      t.datetime :end_time
      t.string :image
      t.references :decidim_feature, index: true
      t.references :decidim_author, index: true
      t.references :decidim_scope, index: true
      t.references :decidim_category, index: true

      t.timestamps
    end
  end
end
