# frozen_string_literal: true

module Decidim
  module Accountability
    module Admin
      module UpdateResultOverride
        extend ActiveSupport::Concern

        included do
          fetch_form_attributes :position
        end
      end
    end
  end
end
