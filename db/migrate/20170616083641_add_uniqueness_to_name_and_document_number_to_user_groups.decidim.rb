# This migration comes from decidim (originally 20170612070905)
# frozen_string_literal: true

class AddUniquenessToNameAndDocumentNumberToUserGroups < ActiveRecord::Migration[5.0]
  def change
    Decidim::UserGroup.select(:document_number).group(:document_number).having("count(*) > 1").count.keys.each do |document_number|
      Decidim::UserGroup.where(document_number: document_number).each_with_index do |user_group, index|
        next if index == 0
        user_group.update_attribute(:document_number, "#{document_number} (#{index})")
      end
    end

    add_index :decidim_user_groups, [:decidim_organization_id, :name], unique: true, name: "index_decidim_user_groups_names_on_organization_id"
    add_index :decidim_user_groups, [:decidim_organization_id, :document_number], unique: true, name: "index_decidim_user_groups_document_number_on_organization_id"
  end
end
