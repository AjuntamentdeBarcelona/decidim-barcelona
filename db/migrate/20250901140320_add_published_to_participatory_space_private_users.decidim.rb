# frozen_string_literal: true

# This migration comes from decidim (originally 20241001140408)
class AddPublishedToParticipatorySpacePrivateUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :decidim_participatory_space_private_users, :published, :boolean, default: false
  end
end
