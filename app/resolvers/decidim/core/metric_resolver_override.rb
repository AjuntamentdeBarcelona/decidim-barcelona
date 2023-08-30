# frozen_string_literal: true

module Decidim
  module Core
    module MetricResolverOverride
      extend ActiveSupport::Concern

      private

      included do
        def sum
          @records = @records.limit(30).sum(counter_field)
        end
      end
    end
  end
end
