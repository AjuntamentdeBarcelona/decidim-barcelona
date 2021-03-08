# frozen_string_literal: true
# This migration comes from decidim (originally 20201019074554)

class AddLocaleToModerationReports < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_reports, :locale, :string
  end
end
