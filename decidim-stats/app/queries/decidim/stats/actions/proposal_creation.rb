# frozen_string_literal: true

module Decidim
  module Stats
    module Actions
      class ProposalCreation
        def initialize(component, performers)
          @component = component
          @performers = performers
        end

        def query
          return [] unless proposals_manifest?

          @query ||=
            Decidim::Coauthorship
            .where(author: performers)
            .where(user_group: nil)
            .where(coauthorable: component_proposals)
            .pluck(:decidim_author_id)
            .uniq
        end

        private

        attr_reader :component, :performers

        def component_manifest
          component.manifest
        end

        def component_proposals
          Decidim::Proposals::Proposal
            .where(component:)
        end

        def proposals_manifest?
          component_manifest.name == :proposals
        end

        def coauthorships_by_performers
          Decidim::Coauthorship.where(author: performers)
        end
      end
    end
  end
end
