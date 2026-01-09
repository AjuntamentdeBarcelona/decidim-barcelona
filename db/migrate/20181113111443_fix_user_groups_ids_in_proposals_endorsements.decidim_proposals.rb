# frozen_string_literal: true

# This migration comes from decidim_proposals (originally 20181003074440)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:13 UTC
class FixUserGroupsIdsInProposalsEndorsements < ActiveRecord::Migration[5.2]
  class ProposalEndorsement < ApplicationRecord
    self.table_name = :decidim_proposals_proposal_endorsements
  end

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

      ProposalEndorsement
        .where(decidim_user_group_id: old_id)
        .update_all(decidim_user_group_id: group.id)
    end
  end
  # rubocop:enable Rails/SkipsModelValidations
end
