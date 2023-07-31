# frozen_string_literal: true
# This migration comes from decidim_initiatives (originally 20220518053612)

class AddCommentsEnabledToInitiativeTypes < ActiveRecord::Migration[6.1]
  def change
    add_column :decidim_initiatives_types, :comments_enabled, :boolean, null: false, default: true
  end
end
