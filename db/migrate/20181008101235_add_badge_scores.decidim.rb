# frozen_string_literal: true
# This migration comes from decidim (originally 20180806095628)

class AddBadgeScores < ActiveRecord::Migration[5.2]
  def change
    create_table :decidim_gamification_badge_scores do |t|
      t.references :user, null: false
      t.string :badge_name, null: false
      t.integer :value, null: false, default: 0
    end
  end
end
