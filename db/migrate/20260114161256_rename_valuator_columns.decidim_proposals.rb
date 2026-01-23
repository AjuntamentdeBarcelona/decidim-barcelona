# frozen_string_literal: true

# This migration comes from decidim_proposals (originally 20250211141313)
class RenameValuatorColumns < ActiveRecord::Migration[7.0]
  def change
    rename_column :decidim_proposals_evaluation_assignments, :valuator_role_type, :evaluator_role_type
    rename_column :decidim_proposals_evaluation_assignments, :valuator_role_id, :evaluator_role_id
  end
end
