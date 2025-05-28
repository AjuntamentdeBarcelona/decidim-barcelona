# frozen_string_literal: true

# This migration comes from decidim_participatory_processes (originally 20240529161054)
class AddLinkToDecidimAttachments < ActiveRecord::Migration[6.1]
  def change
    add_column :decidim_attachments, :link, :string
  end
end
