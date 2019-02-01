# frozen_string_literal: true
# This migration comes from decidim_initiatives (originally 20181212155125)

class AddOnlineSignatureEnabledToInitiativeType < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_initiatives_types, :online_signature_enabled, :boolean, null: false, default: true
  end
end
