# frozen_string_literal: true

module Decidim
  module ParticipatoryProcesses
    module ParticipatoryProcessHelperOverride
      extend ActiveSupport::Concern

      included do
        # Fix double HTML escaping of component names in process navigation.
        #
        # The original helper pre-escapes component names with `decidim_escape_translated`,
        # but the NavLinksCell template escapes them again, causing double-encoding of
        # special characters (e.g., apostrophes show as &#39; instead of ').
        #
        # Backport of https://github.com/decidim/decidim/pull/16419
        def process_nav_items(participatory_space)
          components = participatory_space
                       .components
                       .published.or(Decidim::Component.where(id: try(:current_component)))
                       .where(visible: true)

          [
            *(if participatory_space.members_public_page?
                [{
                  name: t("member_menu_item", scope: "layouts.decidim.participatory_process_navigation"),
                  url: decidim_participatory_processes.participatory_process_participatory_space_private_users_path(participatory_space),
                  active: is_active_link?(decidim_participatory_processes.participatory_process_participatory_space_private_users_path(participatory_space), :inclusive)
                }]
              end
             )
          ] + components.map do |component|
            {
              id: component.id,
              name: translated_attribute(component.name),
              url: main_component_path(component),
              active: is_active_link?(main_component_path(component), :inclusive)
            }
          end.compact
        end
      end
    end
  end
end
