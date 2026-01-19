# frozen_string_literal: true

module Decidim
  module Stats
    module Actions
      class Like
        def initialize(component, performers)
          @component = component
          @performers = performers
        end

        def query
          return [] unless proposals_manifest?

          @query ||=
            Decidim::Like
            .where(resource: proposals)
            .where(author: performers)
            .pluck(:decidim_author_id)
            .uniq
        end

        private

        attr_reader :component, :performers

        def component_manifest
          component.manifest
        end

        def proposals
          Decidim::Proposals::Proposal
            .where(component:)
        end

        def proposals_manifest?
          component_manifest.name == :proposals
        end
      end
    end
  end
end
