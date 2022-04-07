# frozen_string_literal: true

class UpdateOrganizationsAvailableAuthorizations < ActiveRecord::Migration[5.2]
  class Organization < ApplicationRecord
    self.table_name = :decidim_organizations
  end

  def up
    workflows = {}

    Organization.find_each do |organization|
      workflows[organization.id] =
        organization.available_authorizations.index_with do |_workflow|
          { allow_ephemeral_participation: false }
        end
    end

    remove_column :decidim_organizations, :available_authorizations
    add_column :decidim_organizations, :available_authorizations, :jsonb, default: {}

    Organization.find_each do |organization|
      organization.update!(available_authorizations: workflows[organization.id])
    end
  end

  def down
    workflows = {}

    Organization.find_each do |organization|
      workflows[organization.id] = organization.available_authorizations.keys
    end

    remove_column :decidim_organizations, :available_authorizations
    add_column :decidim_organizations, :available_authorizations, :string, array: true, default: []

    Organization.find_each do |organization|
      organization.update!(available_authorizations: workflows[organization.id])
    end
  end
end
