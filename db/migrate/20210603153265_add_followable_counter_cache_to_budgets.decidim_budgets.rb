# frozen_string_literal: true

# This migration comes from decidim_budgets (originally 20210310120613)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:12 UTC
class AddFollowableCounterCacheToBudgets < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_budgets_projects, :follows_count, :integer, null: false, default: 0, index: true

    reversible do |dir|
      dir.up do
        Decidim::Budgets::Project.reset_column_information
        Decidim::Budgets::Project.unscoped.find_each do |record|
          record.class.reset_counters(record.id, :follows)
        end
      end
    end
  end
end
