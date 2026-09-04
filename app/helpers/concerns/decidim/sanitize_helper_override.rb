# frozen_string_literal: true

module Decidim
  # Backport of https://github.com/decidim/decidim/pull/17604
  #
  # `decidim_html_escape` returned a plain (non HTML-safe) String, so views
  # rendering it with `<%= %>` or tag helpers escaped it a second time and
  # texts like `d'oportunitats` ended up displaying `&#39;` literally.
  #
  # Remove once the upstream fix is released and the app is upgraded.
  module SanitizeHelperOverride
    extend ActiveSupport::Concern

    included do
      def decidim_html_escape(text)
        ERB::Util.html_escape(text.to_str)
      end
    end
  end
end
