# frozen_string_literal: true
# This migration comes from decidim_debates (originally 20200703134657)

class CloseDebates < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_debates_debates, :closed_at, :datetime
    add_column :decidim_debates_debates, :conclusions, :jsonb
    add_index :decidim_debates_debates, :closed_at
  end
end
