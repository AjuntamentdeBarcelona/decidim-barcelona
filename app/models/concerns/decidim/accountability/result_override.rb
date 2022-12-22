# frozen_string_literal: true

module Decidim
  module Accountability
    module ResultOverride
      extend ActiveSupport::Concern

      included do
        def self.not_computable_results
          [11_098, 11_131]
        end
      end
    end
  end
end
