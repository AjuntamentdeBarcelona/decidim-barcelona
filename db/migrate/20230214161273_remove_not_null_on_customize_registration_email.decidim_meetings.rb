# frozen_string_literal: true
# This migration comes from decidim_meetings (originally 20211105115625)

class RemoveNotNullOnCustomizeRegistrationEmail < ActiveRecord::Migration[6.0]
  def change
    change_column_null :decidim_meetings_meetings, :customize_registration_email, true
  end
end
