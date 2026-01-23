# frozen_string_literal: true

# This migration comes from decidim (originally 20240717093514)
class AddRegisteredOnlyToDecidimShareTokens < ActiveRecord::Migration[7.0]
  def change
    add_column :decidim_share_tokens, :registered_only, :boolean
  end
end
