# frozen_string_literal: true

# The only nickname index Decidim creates is partial (deleted_at IS NULL AND
# managed = false), so the profile lookups (ProfilesController#profile_holder,
# UserActivitiesController#user), which filter only by nickname and
# organization, cannot use it and scan every user of the organization.
class AddNicknameAndOrganizationIndexToDecidimUsers < ActiveRecord::Migration[7.0]
  disable_ddl_transaction!

  def change
    add_index :decidim_users,
              [:nickname, :decidim_organization_id],
              name: "index_decidim_users_on_nickname_and_decidim_organization_id",
              algorithm: :concurrently,
              if_not_exists: true
  end
end
