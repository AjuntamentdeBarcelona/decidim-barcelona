# frozen_string_literal: true

# This migration comes from decidim_initiatives (originally 20171017094911)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:13 UTC
class AddScopedTypeToInitiative < ActiveRecord::Migration[5.1]
  def change
    add_column :decidim_initiatives,
               :scoped_type_id, :integer, index: true
  end
end
