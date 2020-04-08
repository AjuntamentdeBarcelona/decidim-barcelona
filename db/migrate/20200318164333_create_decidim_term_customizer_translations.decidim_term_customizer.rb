# frozen_string_literal: true
# This migration comes from decidim_term_customizer (originally 20190217132654)

class CreateDecidimTermCustomizerTranslations < ActiveRecord::Migration[5.2]
  def change
    create_table :decidim_term_customizer_translations do |t|
      t.string :locale
      t.string :key
      t.text :value

      t.references(
        :translation_set,
        null: false,
        foreign_key: { to_table: :decidim_term_customizer_translation_sets },
        index: { name: "decidim_term_customizer_translation_translation_set" }
      )
    end
  end
end
