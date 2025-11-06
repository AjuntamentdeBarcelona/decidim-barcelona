# frozen_string_literal: true

module Decidim
  module EmptyCacheHashOverride
    extend ActiveSupport::Concern

    included do
      def cache_hash
        nil
      end
    end
  end
end
