# frozen_string_literal: true
# This migration comes from decidim_initiatives (originally 20200424110930)

class AddAttachmentsEnabledOption < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_initiatives_types, :attachments_enabled, :boolean, null: false, default: false
  end
end
