# frozen_string_literal: true
# This migration comes from decidim_assemblies (originally 20190215093700)

class ResetNegativeChildrenCountCounters < ActiveRecord::Migration[5.2]
  def change
    ids = Decidim::Assembly.where("children_count < 0").pluck(:id)
    ids.each { |id| Decidim::Assembly.reset_counters(id, :children_count) }
  end
end
