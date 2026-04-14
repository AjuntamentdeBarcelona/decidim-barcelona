# frozen_string_literal: true

module Decidim
  module CardMetadataCellOverride
    extend ActiveSupport::Concern

    included do
      private

      # Fix double HTML escaping of participatory space titles in card metadata.
      #
      # The original cell pre-escapes the title with `decidim_escape_translated`,
      # but the view escapes it again, causing double-encoding of special characters
      # (e.g., apostrophes show as &#39; instead of ').
      #
      # Backport of https://github.com/decidim/decidim/pull/16419
      def space_item
        return unless show_space?

        {
          text: translated_attribute(participatory_space.title),
          icon: resource_type_icon_key(participatory_space.class),
          url: Decidim::ResourceLocatorPresenter.new(participatory_space).path
        }
      end
    end
  end
end
