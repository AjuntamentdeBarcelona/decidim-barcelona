# frozen_string_literal: true

# This migration comes from decidim (originally 20170313095436)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:12 UTC
class AddAvailableAuthorizationsToOrganization < ActiveRecord::Migration[5.0]
  class Organization < ApplicationRecord
    self.table_name = :decidim_organizations
  end

  def change
    add_column :decidim_organizations, :available_authorizations, :string, array: true, default: []

    workflows = Decidim::Verifications.workflows.map(&:name)
    Organization.find_each do |org|
      org.update!(available_authorizations: workflows)
    end
  end
end
