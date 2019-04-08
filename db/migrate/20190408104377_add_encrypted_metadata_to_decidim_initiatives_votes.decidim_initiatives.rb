# frozen_string_literal: true
# This migration comes from decidim_initiatives (originally 20181220134322)

class AddEncryptedMetadataToDecidimInitiativesVotes < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_initiatives_votes, :encrypted_metadata, :text
  end
end
