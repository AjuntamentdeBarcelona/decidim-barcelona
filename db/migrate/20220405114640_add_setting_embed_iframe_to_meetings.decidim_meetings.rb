# frozen_string_literal: true
# This migration comes from decidim_meetings (originally 20210602040614)

class AddSettingEmbedIframeToMeetings < ActiveRecord::Migration[6.0]
  def change
    add_column :decidim_meetings_meetings, :show_embedded_iframe, :boolean, default: false
  end
end
