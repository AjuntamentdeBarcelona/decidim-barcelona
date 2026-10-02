# frozen_string_literal: true

module Decidim
  module Accountability
    module Admin
      module ResultFormOverride
        extend ActiveSupport::Concern

        included do
          attribute :position, Integer

          validates :position, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, if: ->(form) { form.position.present? }
        end
      end
    end
  end
end
