# frozen_string_literal: true
# This migration comes from decidim (originally 20180802132147)

class RenameContentBlockOptionsToSettings < ActiveRecord::Migration[5.2]
  def change
    rename_column :decidim_content_blocks, :options, :settings
  end
end
