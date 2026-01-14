# frozen_string_literal: true

# This migration comes from decidim_participatory_processes (originally 20250605114136)
class RemoveHashtagFromParticipatoryProcesses < ActiveRecord::Migration[7.1]
  def change
    remove_column :decidim_participatory_processes, :hashtag, :string, if_exists: true
  end
end
