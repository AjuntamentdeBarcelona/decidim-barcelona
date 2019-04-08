# frozen_string_literal: true
# This migration comes from decidim_initiatives (originally 20181212154456)

class AddCollectExtraUserFieldsToInitiativesTypes < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_initiatives_types, :collect_user_extra_fields, :boolean, default: false
  end
end
