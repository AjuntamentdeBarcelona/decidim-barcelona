# frozen_string_literal: true

# This migration comes from decidim_proposals (originally 20170215132030)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:13 UTC
class AddReferenceToProposals < ActiveRecord::Migration[5.0]
  class Proposal < ApplicationRecord
    self.table_name = :decidim_proposals_proposals
  end

  def change
    add_column :decidim_proposals_proposals, :reference, :string
    Proposal.find_each(&:save)
    change_column_null :decidim_proposals_proposals, :reference, false
  end
end
