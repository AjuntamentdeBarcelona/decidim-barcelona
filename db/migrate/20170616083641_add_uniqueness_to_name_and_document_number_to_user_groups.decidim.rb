# frozen_string_literal: true

# This migration comes from decidim (originally 20170612070905)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:12 UTC
class AddUniquenessToNameAndDocumentNumberToUserGroups < ActiveRecord::Migration[5.0]
  def change
    add_index :decidim_user_groups, [:decidim_organization_id, :name], unique: true, name: "index_decidim_user_groups_names_on_organization_id"
    add_index :decidim_user_groups, [:decidim_organization_id, :document_number], unique: true, name: "index_decidim_user_groups_document_number_on_organization_id"
  end
end
