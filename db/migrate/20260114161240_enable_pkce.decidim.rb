# frozen_string_literal: true

# This migration comes from decidim (originally 20250401153444)
class EnablePkce < ActiveRecord::Migration[7.0]
  def change
    add_column :oauth_access_grants, :code_challenge, :string, null: true
    add_column :oauth_access_grants, :code_challenge_method, :string, null: true
  end
end
