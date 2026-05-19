# frozen_string_literal: true

module Decidim
  # Bridges a Decidim::Taxonomy with the legacy district scope identifiers
  # (`scope_id` and `scope_code`) so that authorization metadata, permission
  # options, and locale labels keep working unchanged after the move away from
  # the deprecated scope model.
  class TaxonomyScope < ApplicationRecord
    self.table_name = "decidim_taxonomy_scopes"

    belongs_to :taxonomy, class_name: "Decidim::Taxonomy"

    validates :scope_id, :taxonomy_id, presence: true, uniqueness: true
  end
end
