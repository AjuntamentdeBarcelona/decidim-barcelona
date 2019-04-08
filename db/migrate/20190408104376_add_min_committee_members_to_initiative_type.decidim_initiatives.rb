# frozen_string_literal: true
# This migration comes from decidim_initiatives (originally 20181213184712)

class AddMinCommitteeMembersToInitiativeType < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_initiatives_types, :minimum_committee_members, :integer, null: true, default: nil
  end
end
