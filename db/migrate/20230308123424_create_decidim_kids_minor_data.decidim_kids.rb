# frozen_string_literal: true
# This migration comes from decidim_kids (originally 20221027211859)

class CreateDecidimKidsMinorData < ActiveRecord::Migration[6.1]
  def change
    create_table :decidim_kids_minor_data do |t|
      t.references :decidim_user, null: false, index: true
      t.string :name # encrypted
      t.string :birthday # encrypted
      t.string :email # encrypted
      t.jsonb :extra_data, null: false, default: {}
      t.timestamps
    end
  end
end
