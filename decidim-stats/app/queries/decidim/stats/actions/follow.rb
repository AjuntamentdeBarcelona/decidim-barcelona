# frozen_string_literal: true

module Decidim
  module Stats
    module Actions
      class Follow
        def initialize(component, performers)
          @component = component
          @performers = performers
        end

        def query
          @query ||=
            component_resource_queries
            .flat_map do |resources_query|
              Decidim::Follow
                .where(user: performers)
                .where(followable: resources_query)
                .pluck(:decidim_user_id)
                .uniq
            end
            .compact
            .uniq
        end

        private

        attr_reader :component, :performers

        def component_manifest
          component.manifest
        end

        def component_resource_queries
          Decidim
            .resource_manifests
            .select { |manifest| manifest.component_manifest == component.manifest }
            .map { |manifest| manifest.model_class.where(component: component) }
        end
      end
    end
  end
end
