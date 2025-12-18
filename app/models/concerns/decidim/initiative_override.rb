# frozen_string_literal: true

module Decidim
  module InitiativeOverride
    extend ActiveSupport::Concern

    included do
      OLD_INITIATIVES = [1, 7, 8].freeze
      OLD_SCOPE_ID = 1
      OLD_SIGNATURES = 15_000

      translatable_fields :question, :definition, :reasons

      def supports_required
        return OLD_SIGNATURES if OLD_INITIATIVES.include?(id)

        scoped_type.supports_required
      end

      def supports_required_for(scope)
        scoped_type = initiative_type_scopes.find_by(decidim_scopes_id: scope&.id)
        return OLD_SIGNATURES if OLD_INITIATIVES.include?(id) && scoped_type&.id == OLD_SCOPE_ID

        scoped_type.supports_required
      end
    end
  end
end
