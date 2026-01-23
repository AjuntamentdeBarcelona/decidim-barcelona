# frozen_string_literal: true

# This migration comes from decidim (originally 20170713131308)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:12 UTC
class MigrateUserRolesToParticipatoryProcessRoles < ActiveRecord::Migration[5.1]
  class ParticipatoryProcess < ApplicationRecord
    self.table_name = :decidim_participatory_processes
  end

  class User < ApplicationRecord
    self.table_name = :decidim_users
  end

  def up
    User.find_each do |user|
      next if user.roles.empty? || user.roles.include?("admin")

      values = processes(user).flat_map do |process|
        user.roles.map do |role|
          "(#{user.id}, #{process.id}, '#{role}', NOW(), NOW())"
        end
      end

      execute("
        INSERT INTO decidim_admin_participatory_process_user_roles
        (decidim_user_id, decidim_participatory_process_id, role, created_at, updated_at)
        VALUES #{values.join(", ")}
      ")
    end
    remove_column :decidim_users, :roles
  end

  private

  def processes(user)
    ParticipatoryProcess.where(decidim_organization_id: user.decidim_organization_id)
  end
end
