# frozen_string_literal: true

# This migration comes from decidim_collaborative_texts (originally 20250213113536)
class CreateCollaborativeTextsVersions < ActiveRecord::Migration[7.0]
  def change
    create_table :decidim_collaborative_texts_versions do |t|
      t.references :document, null: false, index: true
      t.string :body
      t.boolean :draft, null: false, default: false
      t.datetime :deleted_at, index: true
      t.timestamps
    end
  end
end
