# frozen_string_literal: true

module Decidim
  module Blogs
    module ContentBlocks
      module HighlightedPostsCellOverride
        extend ActiveSupport::Concern

        included do
          private

          # Backport of https://github.com/decidim/decidim/pull/17575: upstream
          # orders by created_at, but posts have a configurable publication
          # time that should drive the order.
          def posts
            @posts ||= Decidim::Blogs::Post.published.where(component: published_components).published_at_desc
          end
        end
      end
    end
  end
end
