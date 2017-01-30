class AddExtraToDecidimDebatesDebates < ActiveRecord::Migration[5.0]
  def change
    add_column :decidim_debates_debates, :extra, :jsonb
  end
end
