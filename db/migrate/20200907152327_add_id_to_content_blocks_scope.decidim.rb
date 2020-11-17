# frozen_string_literal: true
# This migration comes from decidim (originally 20200323094443)

class AddIdToContentBlocksScope < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_content_blocks, :scoped_resource_id, :integer
  end
end
