# frozen_string_literal: true

# This migration comes from decidim (originally 20191212102051)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:12 UTC
class RemoveContinuityBadges < ActiveRecord::Migration[5.2]
  class BadgeScore < ApplicationRecord
    self.table_name = :decidim_gamification_badge_scores
  end

  def change
    drop_table :decidim_continuity_badge_statuses

    BadgeScore.where(badge_name: :continuity).delete_all
  end
end
