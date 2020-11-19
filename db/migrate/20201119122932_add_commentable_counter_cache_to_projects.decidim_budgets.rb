# frozen_string_literal: true
# This migration comes from decidim_budgets (originally 20200827154129)

class AddCommentableCounterCacheToProjects < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_budgets_projects, :comments_count, :integer, null: false, default: 0, index: true
    Decidim::Budgets::Project.reset_column_information
    Decidim::Budgets::Project.find_each(&:update_comments_count)
  end
end
