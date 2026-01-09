# frozen_string_literal: true

# This migration comes from decidim (originally 20181025082245)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:12 UTC
class AddTimestampsToComponents < ActiveRecord::Migration[5.2]
  class Component < ApplicationRecord
    self.table_name = :decidim_components
  end

  def change
    add_timestamps :decidim_components, null: true

    # rubocop:disable Rails/SkipsModelValidations
    Component.update_all(created_at: Time.current, updated_at: Time.current)
    # rubocop:enable Rails/SkipsModelValidations

    change_column_null :decidim_components, :created_at, false
    change_column_null :decidim_components, :updated_at, false
  end
end
