# frozen_string_literal: true
# This migration comes from decidim_internal_evaluation (originally 20240625151452)

class CreateDecidimInternalEvaluationInternalEvaluations < ActiveRecord::Migration[6.1]
  def change
    create_table :decidim_internal_evaluation_internal_evaluations do |t|
      t.references :decidim_proposal, null: false, index: { name: "index_decidim_internal_evaluations_on_proposal" }
      t.references :decidim_proposal_state, index: { name: "index_decidim_internal_evaluations_on_proposal_state" }
      t.references :decidim_author, null: false, index: { name: "index_decidim_internal_evaluations_on_author" }
      t.jsonb :body

      t.timestamps
    end
  end
end
