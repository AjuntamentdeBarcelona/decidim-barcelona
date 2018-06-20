# frozen_string_literal: true
# This migration comes from decidim_meetings (originally 20180419131924)

class CreateDecidimAgendas < ActiveRecord::Migration[5.1]
  def change
    create_table :decidim_meetings_agendas do |t|
      t.jsonb :title
      t.references :decidim_meeting, null: false, index: true
      t.boolean :visible

      t.timestamps
    end
  end
end
