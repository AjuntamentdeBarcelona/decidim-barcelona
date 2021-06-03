# frozen_string_literal: true
# This migration comes from decidim (originally 20201013071533)

class AddReportedContentToModerations < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_moderations, :reported_content, :text
  end
end
