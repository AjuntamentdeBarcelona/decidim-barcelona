# frozen_string_literal: true
# This migration comes from decidim_admin (originally 20191118112040)

class AddAcceptedAdminTermsAtFieldToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_users, :admin_terms_accepted_at, :datetime
  end
end
