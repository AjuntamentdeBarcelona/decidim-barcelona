# frozen_string_literal: true

# This migration comes from decidim_initiatives (originally 20190213184301)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:13 UTC
class AddUndoOnlineSignaturesEnabledToInitiativesTypes < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_initiatives_types, :undo_online_signatures_enabled, :boolean, null: false, default: true
  end
end
