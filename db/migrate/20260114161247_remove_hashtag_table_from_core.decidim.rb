# frozen_string_literal: true

# This migration comes from decidim (originally 20250613122148)
class RemoveHashtagTableFromCore < ActiveRecord::Migration[7.2]
  def change
    drop_table :decidim_hashtags, if_exists: true
  end
end
