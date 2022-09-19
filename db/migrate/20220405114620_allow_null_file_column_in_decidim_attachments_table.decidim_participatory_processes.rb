# frozen_string_literal: true
# This migration comes from decidim_participatory_processes (originally 20210415163339)

class AllowNullFileColumnInDecidimAttachmentsTable < ActiveRecord::Migration[6.0]
  def change
    change_column_null :decidim_attachments, :file, true
  end
end
