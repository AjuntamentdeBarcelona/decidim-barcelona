# frozen_string_literal: true
# This migration comes from decidim_participatory_processes (originally 20200114142253)

class AddScopeTypeToParticipatoryProcesses < ActiveRecord::Migration[5.2]
  def change
    add_reference :decidim_participatory_processes, :decidim_scope_type, foreign_key: true, index: true
  end
end
