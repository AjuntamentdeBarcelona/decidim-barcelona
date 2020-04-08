# frozen_string_literal: true
# This migration comes from decidim_term_customizer (originally 20190217132726)

class CreateDecidimTermCustomizerConstraints < ActiveRecord::Migration[5.2]
  def change
    create_table :decidim_term_customizer_constraints do |t|
      t.references :decidim_organization, null: false, foreign_key: true, index: { name: "decidim_term_customizer_constraint_organization" }
      t.references :subject, polymorphic: true, index: { name: "decidim_term_customizer_constraint_subject" }

      t.references(
        :translation_set,
        null: false,
        foreign_key: { to_table: :decidim_term_customizer_translation_sets },
        index: { name: "decidim_term_customizer_constraint_translation_set" }
      )
    end
  end
end
