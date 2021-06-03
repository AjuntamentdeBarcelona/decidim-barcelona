# frozen_string_literal: true
# This migration comes from decidim_initiatives (originally 20210310120720)

class AddFollowableCounterCacheToInitiatives < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_initiatives, :follows_count, :integer, null: false, default: 0, index: true

    reversible do |dir|
      dir.up do
        Decidim::Initiative.reset_column_information
        Decidim::Initiative.find_each do |record|
          record.class.reset_counters(record.id, :follows)
        end
      end
    end
  end
end
