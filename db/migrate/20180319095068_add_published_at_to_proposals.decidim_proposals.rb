# frozen_string_literal: true

# This migration comes from decidim_proposals (originally 20171220084719)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:13 UTC
class AddPublishedAtToProposals < ActiveRecord::Migration[5.1]
  def up
    add_column :decidim_proposals_proposals, :published_at, :datetime, index: true
    # rubocop:disable Rails/SkipsModelValidations
    Decidim::Proposals::Proposal.unscoped.update_all("published_at = updated_at")
    # rubocop:enable Rails/SkipsModelValidations
  end

  def down
    remove_column :decidim_proposals_proposals, :published_at
  end
end
