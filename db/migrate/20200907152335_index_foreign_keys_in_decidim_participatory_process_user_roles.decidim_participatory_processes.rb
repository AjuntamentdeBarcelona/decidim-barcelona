# frozen_string_literal: true
# This migration comes from decidim_participatory_processes (originally 20200320105924)

class IndexForeignKeysInDecidimParticipatoryProcessUserRoles < ActiveRecord::Migration[5.2]
  def change
    add_index :decidim_participatory_process_user_roles, :decidim_user_id, name: "idx_proces_user_role_on_user_id"
  end
end
