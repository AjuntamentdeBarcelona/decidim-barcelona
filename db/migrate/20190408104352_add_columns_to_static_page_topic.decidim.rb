# frozen_string_literal: true

# This migration comes from decidim (originally 20181119140636)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:12 UTC
class AddColumnsToStaticPageTopic < ActiveRecord::Migration[5.2]
  def change
    change_table :decidim_static_page_topics do |t|
      t.column :weight, :integer, default: nil, null: true
      t.column :show_in_footer, :boolean, default: false, null: false
    end
  end
end
