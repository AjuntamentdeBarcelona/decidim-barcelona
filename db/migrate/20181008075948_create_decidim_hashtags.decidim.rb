# frozen_string_literal: true

# This migration comes from decidim (originally 20180726112510)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:12 UTC
class CreateDecidimHashtags < ActiveRecord::Migration[5.2]
  def self.up
    create_table :decidim_hashtags do |t|
      t.references :decidim_organization

      t.string :name, index: true

      t.timestamps
    end
  end

  def self.down
    drop_table :decidim_hashtags
  end
end
