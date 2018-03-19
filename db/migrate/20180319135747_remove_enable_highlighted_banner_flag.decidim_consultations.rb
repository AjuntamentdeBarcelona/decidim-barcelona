# This migration comes from decidim_consultations (originally 20180212100503)
# frozen_string_literal: true

class RemoveEnableHighlightedBannerFlag < ActiveRecord::Migration[5.1]
  def change
    remove_column :decidim_consultations, :enable_highlighted_banner, :boolean, null: false, default: true
  end
end
