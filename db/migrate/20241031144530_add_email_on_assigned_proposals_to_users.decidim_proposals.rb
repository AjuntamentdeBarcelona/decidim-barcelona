# frozen_string_literal: true

# This migration comes from decidim_proposals (originally 20240617091140)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:13 UTC
class AddEmailOnAssignedProposalsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :decidim_users, :email_on_assigned_proposals, :boolean, default: true
  end
end
