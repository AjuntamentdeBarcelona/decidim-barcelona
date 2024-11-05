# frozen_string_literal: true
# This migration comes from decidim_internal_evaluation (originally 20240715150021)

class ChangeInternalEvaluationsBodyToText < ActiveRecord::Migration[6.1]
  def up
    change_column :decidim_internal_evaluation_internal_evaluations, :body, :text
  end

  def down
    change_column :decidim_internal_evaluation_internal_evaluations, :body, :jsonb
  end
end
