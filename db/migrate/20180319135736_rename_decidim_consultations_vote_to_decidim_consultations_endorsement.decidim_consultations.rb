# This migration comes from decidim_consultations (originally 20180129122226)
# frozen_string_literal: true

class RenameDecidimConsultationsVoteToDecidimConsultationsEndorsement < ActiveRecord::Migration[5.1]
  def change
    rename_table :decidim_consultations_votes, :decidim_consultations_endorsements
  end
end
