# frozen_string_literal: true

# This migration comes from decidim_conferences (originally 20200320105914)
class IndexForeignKeysInDecidimConferencesConferenceInvites < ActiveRecord::Migration[5.2]
  def change
    add_index :decidim_conferences_conference_invites, :decidim_conference_registration_type_id, name: "ixd_conferences_on_registration_type_id"
  end
end
