# This migration comes from decidim_initiatives (originally 20171109132011)
class EnablePgExtensions < ActiveRecord::Migration[5.1]
  def change
    begin
      enable_extension 'pg_trgm'
    rescue => e
      puts "Can not deal with pg_trgm extension: #{e}"
    end
  end
end
