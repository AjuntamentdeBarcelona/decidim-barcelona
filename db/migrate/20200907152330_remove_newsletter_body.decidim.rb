# frozen_string_literal: true
# This migration comes from decidim (originally 20200327082954)

class RemoveNewsletterBody < ActiveRecord::Migration[5.2]
  def change
    remove_column :decidim_newsletters, :body
  end
end
