class AddExtraToSteps < ActiveRecord::Migration[5.0]
  def change
    add_column :decidim_participatory_process_steps, :extra, :jsonb
  end
end
