# This migration comes from decidim_participatory_processes (originally 20171215141722)
# frozen_string_literal: true

class AddAttachmentCollectionToAttachments < ActiveRecord::Migration[5.1]
  def change
    add_column :decidim_attachments, :attachment_collection_id, :integer, null: true, index: { name: "index_decidim_attachments_attachment_collection_id" }
    add_foreign_key :decidim_attachments, :decidim_attachment_collections, column: :attachment_collection_id, on_delete: :nullify,
                                                                           name: "fk_decidim_attachments_attachment_collection_id"
  end
end
