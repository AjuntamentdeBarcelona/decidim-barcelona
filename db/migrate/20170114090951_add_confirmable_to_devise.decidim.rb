# frozen_string_literal: true

# This migration comes from decidim (originally 20161006085629)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:12 UTC
class AddConfirmableToDevise < ActiveRecord::Migration[5.0]
  def up
    add_column :decidim_users, :confirmation_token, :string
    add_column :decidim_users, :confirmed_at, :datetime
    add_column :decidim_users, :confirmation_sent_at, :datetime
    add_column :decidim_users, :unconfirmed_email, :string
    add_index :decidim_users, :confirmation_token, unique: true
    execute("UPDATE decidim_users SET confirmed_at = NOW()")
  end

  def down
    remove_columns :decidim_users, :confirmation_token, :confirmed_at, :confirmation_sent_at
  end
end
