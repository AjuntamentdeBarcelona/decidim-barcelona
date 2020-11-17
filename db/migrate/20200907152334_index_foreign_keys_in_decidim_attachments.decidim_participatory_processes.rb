# frozen_string_literal: true
# This migration comes from decidim_participatory_processes (originally 20200320105908)

class IndexForeignKeysInDecidimAttachments < ActiveRecord::Migration[5.2]
  def change
    add_index :decidim_attachments, :attachment_collection_id
  end
end
