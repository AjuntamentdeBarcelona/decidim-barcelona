# frozen_string_literal: true

# This migration comes from decidim (originally 20161010102356)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:13 UTC
class TranslateProcesses < ActiveRecord::Migration[5.0]
  def change
    remove_column :decidim_participatory_processes, :title
    remove_column :decidim_participatory_processes, :subtitle
    remove_column :decidim_participatory_processes, :description
    remove_column :decidim_participatory_processes, :short_description

    change_table :decidim_participatory_processes do |t|
      t.jsonb :title, null: false
      t.jsonb :subtitle, null: false
      t.jsonb :short_description, null: false
      t.jsonb :description, null: false
    end
  end
end
