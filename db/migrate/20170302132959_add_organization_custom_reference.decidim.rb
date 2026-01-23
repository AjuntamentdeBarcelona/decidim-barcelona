# frozen_string_literal: true

# This migration comes from decidim (originally 20170215115407)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:12 UTC
class AddOrganizationCustomReference < ActiveRecord::Migration[5.0]
  class Organization < ApplicationRecord
    self.table_name = :decidim_organizations
  end

  def change
    add_column :decidim_organizations, :reference_prefix, :string

    Organization.find_each do |organization|
      organization.update!(reference_prefix: organization.name[0])
    end

    change_column_null :decidim_organizations, :reference_prefix, false
  end
end
