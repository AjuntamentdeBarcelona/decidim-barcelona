# frozen_string_literal: true

# This migration comes from decidim (originally 20181126145142)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:12 UTC
class AddIdDocumentsFieldsToOrg < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_organizations, :id_documents_methods, :string, array: true, default: ["online"]
    add_column :decidim_organizations, :id_documents_explanation_text, :jsonb, default: {}

    # rubocop:disable Rails/SkipsModelValidations
    Decidim::Organization.reset_column_information
    Decidim::Organization.update_all(id_documents_methods: ["online"])
    # rubocop:enable Rails/SkipsModelValidations
  end
end
