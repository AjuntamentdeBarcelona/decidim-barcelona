# frozen_string_literal: true

# This migration comes from decidim_participatory_processes (originally 20200320105908)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:13 UTC
class IndexForeignKeysInDecidimAttachments < ActiveRecord::Migration[5.2]
  def change
    add_index :decidim_attachments, :attachment_collection_id
  end
end
