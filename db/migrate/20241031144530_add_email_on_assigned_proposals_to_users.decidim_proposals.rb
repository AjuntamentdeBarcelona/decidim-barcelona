# frozen_string_literal: true
# This migration comes from decidim_proposals (originally 20240617091140)

class AddEmailOnAssignedProposalsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :decidim_users, :email_on_assigned_proposals, :boolean, default: true
  end
end
