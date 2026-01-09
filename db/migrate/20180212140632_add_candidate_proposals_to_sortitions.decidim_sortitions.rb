# frozen_string_literal: true

# This migration comes from decidim_sortitions (originally 20180104145344)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:13 UTC
class AddCandidateProposalsToSortitions < ActiveRecord::Migration[5.1]
  def change
    add_column :decidim_module_sortitions_sortitions, :candidate_proposals, :jsonb
  end
end
