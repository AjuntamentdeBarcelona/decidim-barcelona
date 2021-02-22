# frozen_string_literal: true
# This migration comes from decidim (originally 20201004160335)

class RemoveNotificationsWithContinuityBadge < ActiveRecord::Migration[5.2]
  def up
    Decidim::Notification.where("extra->>'badge_name' =?", "continuity").delete_all
  end

  def down; end
end
