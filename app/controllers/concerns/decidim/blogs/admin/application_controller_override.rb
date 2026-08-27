# frozen_string_literal: true

module Decidim
  module Blogs
    module Admin
      module ApplicationControllerOverride
        # Backport of https://github.com/decidim/decidim/pull/17575: upstream
        # applies no ordering to the admin posts list, so posts come out in
        # database insertion order instead of publication time.
        def posts
          @posts ||= super.published_at_desc
        end
      end
    end
  end
end
