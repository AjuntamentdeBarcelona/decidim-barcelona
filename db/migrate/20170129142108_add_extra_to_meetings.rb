class AddExtraToMeetings < ActiveRecord::Migration[5.0]
  def change
    add_column :decidim_meetings_meetings, :extra, :jsonb
  end
end
