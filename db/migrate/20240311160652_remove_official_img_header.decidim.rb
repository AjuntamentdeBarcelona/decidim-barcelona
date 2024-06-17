# frozen_string_literal: true
# This migration comes from decidim (originally 20231123111229)

class RemoveOfficialImgHeader < ActiveRecord::Migration[6.1]
  def up
    remove_column :decidim_organizations, :official_img_header
  end

  def down
    add_column :decidim_organizations, :official_img_header, :string
  end
end
