# frozen_string_literal: true

# This migration comes from decidim_initiatives (originally 20171102094556)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:13 UTC
class CreateInitiativeDescriptionIndex < ActiveRecord::Migration[5.1]
  def up
    execute "CREATE INDEX decidim_initiatives_description_search ON decidim_initiatives(md5(description::text))"
  end

  def down
    execute "DROP INDEX decidim_initiatives_description_search"
  end
end
