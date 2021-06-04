# frozen_string_literal: true
# This migration comes from decidim_meetings (originally 20201016112641)

class AddRegistrationTypeAndUrlToMeetings < ActiveRecord::Migration[5.2]
  class Meetings < ApplicationRecord
    self.table_name = :decidim_meetings_meetings
    include Decidim::HasComponent
  end

  def change
    add_column :decidim_meetings_meetings, :registration_type, :string, null: false, default: "registration_disabled"
    add_column :decidim_meetings_meetings, :registration_url, :string

    Meetings.reset_column_information
    # rubocop:disable Rails/SkipsModelValidations
    Meetings.where(decidim_author_type: "Decidim::Organization").update_all(registration_type: "on_this_platform")
    # rubocop:enable Rails/SkipsModelValidations
  end
end
