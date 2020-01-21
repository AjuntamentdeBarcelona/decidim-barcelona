# frozen_string_literal: true
# This migration comes from decidim_initiatives (originally 20190925145648)

class AddPromotingCommitteeOption < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_initiatives_types, :promoting_committee_enabled, :boolean, null: false, default: true
  end
end
