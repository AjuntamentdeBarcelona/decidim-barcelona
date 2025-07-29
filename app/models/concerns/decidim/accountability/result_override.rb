# frozen_string_literal: true

module Decidim
  module Accountability
    module ResultOverride
      extend ActiveSupport::Concern

      included do
        before_validation :remove_external_id, if: -> { external_id.blank? }

        def self.not_computable_results
          [11_098, 11_131]
        end

        private

        def remove_external_id
          self.external_id = nil
        end
      end
    end
  end
end
