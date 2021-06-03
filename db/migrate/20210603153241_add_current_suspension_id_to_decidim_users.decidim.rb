# frozen_string_literal: true
# This migration comes from decidim (originally 20201011081626)

class AddCurrentSuspensionIdToDecidimUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_users, :suspension_id, :integer
  end
end
