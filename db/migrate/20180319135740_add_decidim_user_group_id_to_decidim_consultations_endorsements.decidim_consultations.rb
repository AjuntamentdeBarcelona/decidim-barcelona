# This migration comes from decidim_consultations (originally 20180130142018)
# frozen_string_literal: true

class AddDecidimUserGroupIdToDecidimConsultationsEndorsements < ActiveRecord::Migration[5.1]
  def change
    add_column :decidim_consultations_endorsements, :decidim_user_group_id, :integer, index: true
  end
end
