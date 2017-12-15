# This migration comes from decidim_initiatives (originally 20171023075942)
class CreateInitiativeExtraData < ActiveRecord::Migration[5.1]
  def change
    create_table :decidim_initiatives_extra_data do |t|
      t.references :decidim_initiative, null: false, index: true
      t.integer :data_type, null: false, default: 0
      t.jsonb :data, null: false
    end
  end
end
