# frozen_string_literal: true

# This migration comes from decidim_initiatives (originally 20171013090432)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:13 UTC
class AddInitiativeSupportsCountToInitiative < ActiveRecord::Migration[5.1]
  class Initiative < ApplicationRecord
    self.table_name = :decidim_initiatives
  end

  def change
    add_column :decidim_initiatives, :initiative_supports_count, :integer, null: false, default: 0

    reversible do |change|
      change.up do
        Initiative.find_each do |initiative|
          initiative.initiative_supports_count = initiative.votes.supports.count
          initiative.save
        end
      end
    end
  end
end
