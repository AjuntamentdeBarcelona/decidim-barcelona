# frozen_string_literal: true

# This migration comes from decidim (originally 20250327143657)
class RemoveMetricsContentBlocks < ActiveRecord::Migration[7.0]
  def up
    Decidim::ContentBlock.where(manifest_name: "metrics").destroy_all
  end

  def down; end
end
