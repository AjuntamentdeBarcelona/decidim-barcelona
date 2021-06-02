# frozen_string_literal: true
# This migration comes from decidim (originally 20210208134328)

class AddEmailOnModerationsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_users, :email_on_moderations, :boolean, default: true
  end
end
