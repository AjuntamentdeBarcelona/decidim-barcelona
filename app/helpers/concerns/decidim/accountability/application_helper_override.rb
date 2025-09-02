# frozen_string_literal: true

module Decidim
  module Accountability
    module ApplicationHelperOverride
      extend ActiveSupport::Concern

      included do
        def display_count(count)
          heading_parent_level_results(count)
        end

        def heading_parent_level_results(count)
          if component_settings.respond_to?(:heading_parent_level_results) && (text = translated_attribute(component_settings.heading_parent_level_results).presence)
            pluralize(count, text)
          else
            t("results.count.results_count", scope: "decidim.accountability", count:)
          end
        end

        def taxonomies_label
          if component_settings.respond_to?(:taxonomies_label) && (text = translated_attribute(component_settings.taxonomies_label).presence)
            text
          else
            t("models.result.fields.taxonomies", scope: "decidim.accountability")
          end
        end
      end
    end
  end
end
