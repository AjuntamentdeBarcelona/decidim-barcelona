# This migration comes from decidim (originally 20170117142904)
class AddUniquenessFieldToAuthorizations < ActiveRecord::Migration[5.0]
  def change
    change_table :decidim_authorizations do |t|
      t.string :unique_id, null: true
    end
  end
end
