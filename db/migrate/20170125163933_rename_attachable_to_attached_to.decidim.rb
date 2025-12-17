# frozen_string_literal: true

# This migration comes from decidim (originally 20170125135937)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:13 UTC
class RenameAttachableToAttachedTo < ActiveRecord::Migration[5.0]
  def change
    remove_index :decidim_attachments, name: "index_decidim_attachments_on_attachable_id_and_attachable_type"
    remove_foreign_key :decidim_attachments, column: :attachable_id

    rename_column :decidim_attachments, :attachable_id, :attached_to_id
    rename_column :decidim_attachments, :attachable_type, :attached_to_type

    add_index :decidim_attachments, [:attached_to_id, :attached_to_type], name: "index_decidim_attachments_on_attached_to"
  end
end
