# frozen_string_literal: true

# This migration comes from decidim_comments (originally 20181003080320)
# This file has been modified by `decidim upgrade:migrations` task on 2026-01-14 16:12:35 UTC
class FixUserGroupsIdsInComments < ActiveRecord::Migration[5.2]
  class UserGroup < ApplicationRecord
    self.table_name = :decidim_users
    self.inheritance_column = nil # disable the default inheritance

    default_scope { where(type: "Decidim::UserGroup") }
  end

  # rubocop:disable Rails/SkipsModelValidations
  def change
    UserGroup.find_each do |group|
      old_id = group.extended_data["old_user_group_id"]
      next unless old_id

      Decidim::Comments::Comment
        .where(decidim_user_group_id: old_id)
        .update_all(decidim_user_group_id: group.id)
    end
  end
  # rubocop:enable Rails/SkipsModelValidations
end
