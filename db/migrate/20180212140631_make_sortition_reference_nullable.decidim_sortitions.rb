# This migration comes from decidim_sortitions (originally 20180104143054)
# frozen_string_literal: true

class MakeSortitionReferenceNullable < ActiveRecord::Migration[5.1]
  def change
    change_column_null :decidim_module_sortitions_sortitions, :reference, true
  end
end
