# frozen_string_literal: true

# This migration comes from decidim_participatory_processes (originally 20251205120001)
class AddHasMembersToDecidimParticipatoryProcesses < ActiveRecord::Migration[7.0]
  def change
    add_column :decidim_participatory_processes, :has_members, :boolean, default: false
  end
end
