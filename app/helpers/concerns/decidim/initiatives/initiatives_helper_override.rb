# frozen_string_literal: true

module Decidim
  module Initiatives
    module InitiativesHelperOverride
      extend ActiveSupport::Concern

      included do
        # Fix double HTML escaping of component names in initiative navigation.
        #
        # The original helper pre-escapes component names with `decidim_escape_translated`,
        # but the NavLinksCell template escapes them again, causing double-encoding of
        # special characters (e.g., apostrophes show as &#39; instead of ').
        #
        # Backport of https://github.com/decidim/decidim/pull/16419
        def initiative_nav_items(participatory_space)
          components = participatory_space
                       .components
                       .published.or(Decidim::Component.where(id: try(:current_component)))
                       .where(visible: true)

          components.map do |component|
            {
              name: translated_attribute(component.name),
              url: main_component_path(component),
              active: is_active_link?(main_component_path(component), :inclusive)
            }
          end
        end
      end
    end
  end
end
