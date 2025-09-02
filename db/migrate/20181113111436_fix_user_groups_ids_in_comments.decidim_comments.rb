# frozen_string_literal: true

# This migration comes from decidim_comments (originally 20181003080320)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:12 UTC
class FixUserGroupsIdsInComments < ActiveRecord::Migration[5.2]
  # rubocop:disable Rails/SkipsModelValidations
  def change
    Decidim::UserGroup.find_each do |group|
      old_id = group.extended_data["old_user_group_id"]
      next unless old_id

      Decidim::Comments::Comment
        .where(decidim_user_group_id: old_id)
        .update_all(decidim_user_group_id: group.id)
    end
  end
  # rubocop:enable Rails/SkipsModelValidations
end
