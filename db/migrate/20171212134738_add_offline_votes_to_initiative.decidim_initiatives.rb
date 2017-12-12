# This migration comes from decidim_initiatives (originally 20171031183855)
class AddOfflineVotesToInitiative < ActiveRecord::Migration[5.1]
  def change
    add_column :decidim_initiatives,
               :offline_votes, :integer
  end
end
