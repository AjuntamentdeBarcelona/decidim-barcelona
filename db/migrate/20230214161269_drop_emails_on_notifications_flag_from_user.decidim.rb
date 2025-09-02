# frozen_string_literal: true

# This migration comes from decidim (originally 20220427142214)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:13 UTC
class DropEmailsOnNotificationsFlagFromUser < ActiveRecord::Migration[5.1]
  class DecidimUser < ApplicationRecord
    self.table_name = :decidim_users
  end

  def change
    # rubocop:disable Rails/SkipsModelValidations
    DecidimUser.where(email_on_notification: true).update_all(notifications_sending_frequency: "real_time")
    # rubocop:enable Rails/SkipsModelValidations

    remove_column :decidim_users, :email_on_notification
  end
end
