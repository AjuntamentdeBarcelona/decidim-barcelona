# frozen_string_literal: true
# This migration comes from decidim_debates (originally 20200930145546)

class AddScopeToDebatesDebate < ActiveRecord::Migration[5.2]
  def change
    add_reference :decidim_debates_debates, :decidim_scope, foreign_key: true, index: true
  end
end
