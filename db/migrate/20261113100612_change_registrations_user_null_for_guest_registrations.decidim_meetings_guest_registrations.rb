# frozen_string_literal: true

# This migration comes from decidim_meetings_guest_registrations (originally 20261105115626)
# Guest registrations have no user. The unique index on
# (decidim_user_id, decidim_meeting_id) stays valid because PostgreSQL does not
# consider two NULL values equal.
#
# WARNING: rolling this migration back DELETES every guest registration (and,
# through the foreign key, their personal data), because NOT NULL cannot be
# restored while they exist.
class ChangeRegistrationsUserNullForGuestRegistrations < ActiveRecord::Migration[8.1]
  def up
    change_column_null :decidim_meetings_registrations, :decidim_user_id, true
  end

  def down
    execute "DELETE FROM decidim_meetings_registrations WHERE decidim_user_id IS NULL"
    change_column_null :decidim_meetings_registrations, :decidim_user_id, false
  end
end
