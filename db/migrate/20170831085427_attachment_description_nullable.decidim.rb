# This migration comes from decidim (originally 20170804125402)
# frozen_string_literal: true

class AttachmentDescriptionNullable < ActiveRecord::Migration[5.1]
  def change
    change_column :decidim_attachments, :description, :jsonb, null: true
  end
end
