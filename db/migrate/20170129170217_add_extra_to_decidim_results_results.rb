class AddExtraToDecidimResultsResults < ActiveRecord::Migration[5.0]
  def change
    add_column :decidim_results_results, :extra, :jsonb
  end
end
