# frozen_string_literal: true
# This migration comes from decidim_term_customizer (originally 20190217132503)

class CreateDecidimTermCustomizerTranslationSets < ActiveRecord::Migration[5.2]
  def change
    create_table :decidim_term_customizer_translation_sets do |t|
      t.jsonb :name
    end
  end
end
