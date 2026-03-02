# frozen_string_literal: true

# This migration comes from decidim (originally 20250221090905)
class CreateDecidimApiJwtDenylist < ActiveRecord::Migration[7.0]
  def change
    create_table :decidim_api_jwt_denylists do |t|
      t.string :jti, null: false
      t.datetime :exp, null: false
    end
    add_index :decidim_api_jwt_denylists, :jti
  end
end
