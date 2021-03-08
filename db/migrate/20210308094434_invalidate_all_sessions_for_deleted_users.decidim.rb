# frozen_string_literal: true
# This migration comes from decidim (originally 20210302150803)

class InvalidateAllSessionsForDeletedUsers < ActiveRecord::Migration[5.2]
  def up
    Decidim::User.reset_column_information

    Decidim::User.where.not(deleted_at: nil).find_each do |user|
      user.session_token = SecureRandom.hex
      user.save(validate: false)
    end
  end

  def down; end
end
