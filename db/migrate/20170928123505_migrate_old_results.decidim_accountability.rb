# This migration comes from decidim_accountability (originally 20170928073905)
# frozen_string_literal: true

class MigrateOldResults < ActiveRecord::Migration[5.1]
  class OldResult < ApplicationRecord
    self.table_name = :decidim_results_results
  end

  class Categorization < ApplicationRecord
    self.table_name = :decidim_categorizations
  end

  class Result < ApplicationRecord
    self.table_name = :decidim_accountability_results
  end

  class Feature < ApplicationRecord
    self.table_name = :decidim_features
  end

  class ResourceLink < ApplicationRecord
    self.table_name = :decidim_resource_links
  end

  def up
    add_column :decidim_accountability_results, :legacy_id, :integer

    # Store existing accountability results in memory
    results = Result.all.to_a
    Result.delete_all

    # rubocop:disable Rails/SkipsModelValidations
    old_results = OldResult.all.to_a
    old_results.each do |old_result|
      Result.create!(
        id: old_result.id,
        decidim_feature_id: old_result.decidim_feature_id,
        decidim_scope_id: old_result.decidim_scope_id,
        title: old_result.title,
        description: old_result.description
      )
    end

    execute "SELECT setval('decidim_accountability_results_id_seq', COALESCE((SELECT MAX(id)+1 FROM decidim_accountability_results), 1), false);"

    # Copy stored accountability results
    results.each do |result|
      new_result = Result.create!(
        title: result.title,
        description: result.description,
        reference: result.reference,
        start_date: result.start_date,
        end_date: result.end_date,
        progress: result.progress,
        external_id: result.external_id,
        parent_id: result.parent_id,
        decidim_accountability_status_id: result.decidim_accountability_status_id,
        decidim_feature_id: result.decidim_feature_id,
        decidim_scope_id: result.decidim_scope_id,
        created_at: result.created_at,
        updated_at: result.updated_at,
        children_count: result.children_count,
        legacy_id: result.id,
      )

      Categorization.where(
        categorizable_id: result.id,
        categorizable_type: "Decidim::Accountability::Result"
      ).update_all("categorizable_id = #{new_result.id}")

      ResourceLink.where(
        from_id: result.id,
        from_type: "Decidim::Accountability::Result"
      ).update_all("from_id = #{new_result.id}")
    end

    old_results.each do |old_result|
      Categorization.where(
        categorizable_id: old_result.id,
        categorizable_type: "Decidim::Results::Result"
      ).update_all("categorizable_type = 'Decidim::Accountability::Result'")

      ResourceLink.where(
        from_id: old_result.id,
        from_type: "Decidim::Results::Result"
      ).update_all("from_type = 'Decidim::Accountability::Result'")
    end
    
    Feature.where(manifest_name: "results").update_all("manifest_name = 'accountability'")

    drop_table :decidim_results_results
  end
  # rubocop:enable Rails/SkipsModelValidations
end
