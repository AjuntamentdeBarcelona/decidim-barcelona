# frozen_string_literal: true

# This migration comes from decidim (originally 20220215172439)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:13 UTC
class AddDigestSentAtToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :decidim_users, :digest_sent_at, :datetime
  end
end
