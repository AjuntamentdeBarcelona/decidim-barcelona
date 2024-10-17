# frozen_string_literal: true

module Decidim
  module Stats
    module Actions
      class Endorsement
        def initialize(component, performers)
          @component = component
          @performers = performers
        end

        def query
          return [] unless proposals_manifest?

          @query ||=
            query_base
            .where(decidim_user_group_id: 0)
            .where(author: performers)
            .pluck(:decidim_author_id)
            .uniq
        end

        private

        attr_reader :component, :performers

        def component_manifest
          component.manifest
        end

        def query_base
          Decidim::Endorsement.where(resource: proposals)
        rescue NameError
          Decidim::Proposals::ProposalEndorsement
            .where(proposal: proposals)
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
