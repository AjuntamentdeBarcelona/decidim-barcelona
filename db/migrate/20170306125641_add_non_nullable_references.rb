class AddNonNullableReferences < ActiveRecord::Migration[5.0]
  def change
    change_column_null :decidim_results_results, :reference, false
    change_column_null :decidim_proposals_proposals, :reference, false
  end
end
