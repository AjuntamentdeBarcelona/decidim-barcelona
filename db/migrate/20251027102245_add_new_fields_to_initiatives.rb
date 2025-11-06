class AddNewFieldsToInitiatives < ActiveRecord::Migration[7.0]
  def change
    add_column :decidim_initiatives, :question, :jsonb
    add_column :decidim_initiatives, :definition, :jsonb
    add_column :decidim_initiatives, :reasons, :jsonb
    add_column :decidim_initiatives, :has_custom_fields, :boolean, default: false, null: false
  end
end
