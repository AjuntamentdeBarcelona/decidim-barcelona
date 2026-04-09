# frozen_string_literal: true

module Decidim
  module SanitizeHelperOverride
    extend ActiveSupport::Concern

    included do
      # Fix double HTML escaping of apostrophes and other special characters.
      #
      # Decidim's `decidim_html_escape` uses `ERB::Util.unwrapped_html_escape` which
      # by design returns a plain String (not html_safe). When the result is rendered
      # with `<%= %>`, Rails HTML-escapes it again, causing double encoding:
      #   ' → &#39; → &amp;#39; → browser shows "&#39;" instead of "'"
      #
      # Additionally, `SafeBuffer#to_str` returns a plain String in Rails 7.x,
      # which causes re-escaping when `decidim_escape_translated` is called on
      # an already-escaped SafeBuffer (e.g., in nav_links where it's called twice).
      #
      # This is particularly visible in Catalan due to frequent apostrophe usage
      # (l'alcalde, d'actuació, etc.) but affects all HTML-special characters.
      #
      # The fix:
      # 1. Returns already html_safe content as-is (prevents double-escaping)
      # 2. Marks the escaped result as html_safe (prevents re-escaping by ERB)
      def decidim_html_escape(text)
        return text if text.html_safe?

        ERB::Util.unwrapped_html_escape(text.to_str).html_safe
      end
    end
  end
end
