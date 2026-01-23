# frozen_string_literal: true

# This migration comes from decidim_participatory_processes (originally 20250605114415)
class RemoveHashtagFromParticipatoryProcessesGroups < ActiveRecord::Migration[7.1]
  def change
    remove_column :decidim_participatory_process_groups, :hashtag, :string, if_exists: true
  end
end
