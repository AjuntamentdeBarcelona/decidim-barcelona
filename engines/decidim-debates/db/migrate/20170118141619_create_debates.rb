class CreateDebates < ActiveRecord::Migration[5.0]
  def change
    create_table :debates do |t|
      t.jsonb :title
      t.jsonb :description
      t.datetime :open_date
      t.datetime :close_date
      t.string :image
      t.references :decidim_feature, index: true
      t.references :decidim_author, index: true
      t.references :decidim_scope, index: true
      t.references :decidim_category, index: true

      t.timestamps
    end
  end
end
