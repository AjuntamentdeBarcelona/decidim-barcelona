# This migration comes from decidim_initiatives (originally 20171017094911)
class AddScopedTypeToInitiative < ActiveRecord::Migration[5.1]
  def change
    add_column :decidim_initiatives,
               :scoped_type_id, :integer, index: true
  end
end
