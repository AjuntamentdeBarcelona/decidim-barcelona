# frozen_string_literal: true

# This migration comes from decidim (originally 20170808071019)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:12 UTC
class CreateDecidimNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :decidim_notifications do |t|
      t.references :decidim_user, null: false
      t.references :decidim_resource, polymorphic: true, index: false, null: false
      t.string :event_name, null: false
      t.string :event_class, null: false
      t.timestamps
    end
  end
end
