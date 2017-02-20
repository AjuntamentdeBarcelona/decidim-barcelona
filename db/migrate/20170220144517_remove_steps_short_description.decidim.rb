# This migration comes from decidim (originally 20170220110740)
class RemoveStepsShortDescription < ActiveRecord::Migration[5.0]
  def change
    remove_column :decidim_participatory_process_steps, :short_description
  end
end
