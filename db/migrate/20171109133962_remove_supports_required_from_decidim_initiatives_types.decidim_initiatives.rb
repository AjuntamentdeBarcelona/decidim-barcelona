# This migration comes from decidim_initiatives (originally 20171017091458)
class RemoveSupportsRequiredFromDecidimInitiativesTypes < ActiveRecord::Migration[5.1]
  def change
    remove_column :decidim_initiatives_types, :supports_required, :integer, null: false
  end
end
