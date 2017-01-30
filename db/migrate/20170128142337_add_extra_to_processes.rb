class AddExtraToProcesses < ActiveRecord::Migration[5.0]
  def change
    add_column :decidim_participatory_processes, :extra, :jsonb
  end
end
