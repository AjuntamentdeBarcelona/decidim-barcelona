# frozen_string_literal: true
# This migration comes from decidim_vocdoni (originally 20221204131113)

class CreateDecidimVocdoniElections < ActiveRecord::Migration[6.1]
  def change
    create_table :decidim_vocdoni_elections do |t|
      t.jsonb :title
      t.jsonb :description
      t.string :stream_uri
      t.datetime :start_time
      t.datetime :end_time
      t.datetime :published_at
      t.datetime :blocked_at
      t.string :status
      t.references :decidim_component, index: true

      t.timestamps
    end
  end
end
