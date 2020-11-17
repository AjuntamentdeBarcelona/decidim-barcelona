# frozen_string_literal: true
# This migration comes from decidim (originally 20200320105917)

class IndexForeignKeysInDecidimContextualHelpSections < ActiveRecord::Migration[5.2]
  def change
    add_index :decidim_contextual_help_sections, :section_id
  end
end
