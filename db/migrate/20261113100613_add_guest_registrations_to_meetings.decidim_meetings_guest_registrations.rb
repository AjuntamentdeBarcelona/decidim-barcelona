# frozen_string_literal: true

# This migration comes from decidim_meetings_guest_registrations (originally 20261105115631)
class AddGuestRegistrationsToMeetings < ActiveRecord::Migration[8.1]
  def change
    add_column :decidim_meetings_meetings, :guest_registrations_enabled, :boolean, default: false, null: false
    add_column :decidim_meetings_meetings, :guest_registrations_privacy_text, :jsonb
  end
end
