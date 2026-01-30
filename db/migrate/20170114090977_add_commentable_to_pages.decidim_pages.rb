# frozen_string_literal: true

# This migration comes from decidim_pages (originally 20161214150429)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:13 UTC
class AddCommentableToPages < ActiveRecord::Migration[5.0]
  def change
    add_column :decidim_pages_pages, :commentable, :boolean, null: false, default: false
  end
end
