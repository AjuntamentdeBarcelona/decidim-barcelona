# frozen_string_literal: true

# This migration comes from decidim_sortitions (originally 20180102100101)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:13 UTC
class AddAuthorToSortitions < ActiveRecord::Migration[5.1]
  def change
    add_reference :decidim_module_sortitions_sortitions, :decidim_author, index: true
  end
end
