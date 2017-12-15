# This migration comes from decidim_initiatives (originally 20171102094556)
class CreateInitiativeDescriptionIndex < ActiveRecord::Migration[5.1]
  def up
    execute 'CREATE INDEX decidim_initiatives_description_search ON decidim_initiatives(md5(description::text))'
  end

  def down
    execute 'DROP INDEX decidim_initiatives_description_search'
  end
end
