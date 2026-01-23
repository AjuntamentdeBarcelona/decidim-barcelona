# frozen_string_literal: true

# This migration comes from decidim (originally 20180613080638)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:12 UTC
class RenameMissingFeaturesToComponents < ActiveRecord::Migration[5.1]
  class Notification < ApplicationRecord
    self.table_name = :decidim_notifications
  end

  def up
    # rubocop:disable Rails/SkipsModelValidations
    Notification.where(decidim_resource_type: "Decidim::Feature").update_all(decidim_resource_type: "Decidim::Component")
    Notification.where(event_class: "Decidim::FeaturePublishedEvent").update_all(event_class: "Decidim::ComponentPublishedEvent")
    Notification.where(event_name: "decidim.events.features.feature_published").update_all(event_name: "decidim.events.components.component_published")
    # rubocop:enable Rails/SkipsModelValidations
  end
end
