class AddExtraToDecidimUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :decidim_users, :extra, :jsonb
  end
end
