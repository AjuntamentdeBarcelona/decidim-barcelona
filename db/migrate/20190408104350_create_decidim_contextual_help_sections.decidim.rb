# frozen_string_literal: true

# This migration comes from decidim (originally 20181113101935)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:12 UTC
class CreateDecidimContextualHelpSections < ActiveRecord::Migration[5.2]
  def change
    create_table :decidim_contextual_help_sections do |t|
      t.string :section_id, null: false
      t.references :organization, null: false
      t.jsonb :content, null: false
    end
  end
end
