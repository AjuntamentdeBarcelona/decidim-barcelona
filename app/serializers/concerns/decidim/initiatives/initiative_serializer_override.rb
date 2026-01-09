# frozen_string_literal: true

module Decidim
  module Initiatives
    module InitiativeSerializerOverride
      extend ActiveSupport::Concern

      included do
        # Override serialize to include new fields
        def serialize
          {
            id: resource.id,
            title: resource.title,
            description: resource.description,
            question: resource.question,
            definition: resource.definition,
            reasons: resource.reasons,
            state: resource.state,
            created_at: resource.created_at,
            published_at: resource.published_at,
            signature_end_date: resource.signature_end_date,
            signature_type: resource.signature_type,
            signatures: resource.supports_count,
            scope: {
              name: resource.scope&.name
            },
            type: {
              title: resource.type&.title
            },
            authors: {
              id: resource.author_users.map(&:id),
              name: resource.author_users.map(&:name)
            },
            area: {
              name: resource.area&.name
            }
          }
        end
      end
    end
  end
end
