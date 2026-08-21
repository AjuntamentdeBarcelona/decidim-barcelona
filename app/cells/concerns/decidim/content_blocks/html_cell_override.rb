# frozen_string_literal: true

module Decidim
  module ContentBlocks
    # Reverts the sanitization introduced in Decidim 0.31.5 (CVE-2026-45572) so
    # that admins can keep embedding JavaScript in the HTML content block.
    # Accepted risk: the setting is only editable by admins.
    module HtmlCellOverride
      extend ActiveSupport::Concern

      included do
        def html_content
          translated_attribute(model.settings.html_content).html_safe
        end
      end
    end
  end
end
