# frozen_string_literal: true

# This migration comes from decidim_meetings (originally 20210602040614)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:13 UTC
class AddSettingEmbedIframeToMeetings < ActiveRecord::Migration[6.0]
  def change
    add_column :decidim_meetings_meetings, :show_embedded_iframe, :boolean, default: false
  end
end
