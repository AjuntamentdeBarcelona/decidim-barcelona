# frozen_string_literal: true

# This migration comes from decidim (originally 20201011074641)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:13 UTC
class CreateDecidimUserSuspensions < ActiveRecord::Migration[5.2]
  def change
    create_table :decidim_user_suspensions do |t|
      t.belongs_to :decidim_user, foreign_key: true
      t.integer :suspending_user_id
      t.text :justification

      t.timestamps
    end
    add_foreign_key :decidim_user_suspensions, :decidim_users, column: :suspending_user_id
  end
end
