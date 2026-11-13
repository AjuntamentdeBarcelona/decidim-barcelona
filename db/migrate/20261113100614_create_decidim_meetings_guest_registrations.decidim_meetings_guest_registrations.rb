# frozen_string_literal: true

# This migration comes from decidim_meetings_guest_registrations (originally 20261105115637)
class CreateDecidimMeetingsGuestRegistrations < ActiveRecord::Migration[8.1]
  def change
    create_table :decidim_meetings_guest_registrations do |t|
      t.references :decidim_meetings_registration,
                   null: false,
                   index: { unique: true, name: "index_guest_registrations_on_registration_id" },
                   foreign_key: { to_table: :decidim_meetings_registrations, on_delete: :cascade }
      t.references :decidim_meeting,
                   null: false,
                   index: false,
                   foreign_key: { to_table: :decidim_meetings_meetings, on_delete: :cascade }

      # Encrypted with Decidim::AttributeEncryptor (secret_key_base).
      t.text :name, null: false
      t.text :email, null: false
      t.text :phone, null: false

      # HMAC of the normalized email, to enforce one registration per email.
      t.string :email_digest, null: false
      t.string :locale, null: false
      # Links the registration form responses (decidim_forms_responses.session_token).
      t.string :session_token, null: false

      t.timestamps
    end

    add_index :decidim_meetings_guest_registrations,
              [:decidim_meeting_id, :email_digest],
              unique: true,
              name: "index_guest_registrations_on_meeting_and_email_digest"
  end
end
