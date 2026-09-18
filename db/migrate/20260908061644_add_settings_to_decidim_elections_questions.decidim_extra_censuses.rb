# frozen_string_literal: true

# This migration comes from decidim_extra_censuses (originally 20260413000001)
class AddSettingsToDecidimElectionsQuestions < ActiveRecord::Migration[7.0]
  def change
    add_column :decidim_elections_questions, :settings, :jsonb, default: {}, null: false
  end
end
