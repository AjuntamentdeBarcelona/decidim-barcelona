# frozen_string_literal: true

# This migration comes from decidim (originally 20210310120640)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:13 UTC
class AddFollowableCounterCacheToUsers < ActiveRecord::Migration[5.2]
  class Follow < ApplicationRecord
    self.table_name = "decidim_follows"
  end

  class User < ApplicationRecord
    self.table_name = "decidim_users"
    self.inheritance_column = nil # disable the default inheritance

    default_scope { where(type: "Decidim::User") }
  end

  def change
    add_column :decidim_users, :follows_count, :integer, null: false, default: 0, index: true

    reversible do |dir|
      dir.up do
        User.find_each do |record|
          record.update!(follows_count: Follow.where(decidim_user_id: record.id).count)
        end
      end
    end
  end
end
