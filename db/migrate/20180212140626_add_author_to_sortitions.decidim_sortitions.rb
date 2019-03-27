# This migration comes from decidim_sortitions (originally 20180102100101)
# frozen_string_literal: true

class AddAuthorToSortitions < ActiveRecord::Migration[5.1]
  def change
    add_reference :decidim_module_sortitions_sortitions, :decidim_author, index: true
  end
end
