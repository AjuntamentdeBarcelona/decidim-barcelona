# frozen_string_literal: true

# This migration comes from decidim_assemblies (originally 20180426162405)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:12 UTC
class AssemblyMemberBelongsToUser < ActiveRecord::Migration[5.1]
  def change
    add_reference :decidim_assembly_members, :decidim_user, index: { name: "index_decidim_assembly_members_on_decidim_user_id" }
  end
end
