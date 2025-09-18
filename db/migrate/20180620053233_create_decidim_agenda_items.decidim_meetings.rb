# frozen_string_literal: true

# This migration comes from decidim_meetings (originally 20180419132104)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:13 UTC
class CreateDecidimAgendaItems < ActiveRecord::Migration[5.1]
  def change
    create_table :decidim_meetings_agenda_items do |t|
      t.references :decidim_agenda, index: true
      t.integer :position
      t.references :parent, index: true
      t.integer :duration
      t.jsonb :title
      t.jsonb :description

      t.timestamps
    end
  end
end
