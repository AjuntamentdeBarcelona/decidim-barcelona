# frozen_string_literal: true

# This migration comes from decidim (originally 20161116115156)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:13 UTC
class CreateAttachments < ActiveRecord::Migration[5.0]
  def change
    create_table :decidim_participatory_process_attachments do |t|
      t.jsonb :title, null: false
      t.jsonb :description, null: false
      t.string :file, null: false
      t.string :content_type, null: false
      t.string :file_size, null: false
      t.references :decidim_participatory_process,
                   foreign_key: true,
                   index: { name: "index_decidim_processes_attachments_on_decidim_process_id" }

      t.timestamps
    end
  end
end
