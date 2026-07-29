# frozen_string_literal: true

# This migration comes from decidim (originally 20260217152425)
class RemoveEnableParticipatorySpaceFiltersFromDecidimOrganizations < ActiveRecord::Migration[7.2]
  def change
    remove_column :decidim_organizations, :enable_participatory_space_filters, :boolean
  end
end
