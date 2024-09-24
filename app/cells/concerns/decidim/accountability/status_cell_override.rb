# frozen_string_literal: true

module Decidim
  module Accountability
    module StatusCellOverride
      extend ActiveSupport::Concern

      included do
        include Decidim::Accountability::ApplicationHelper
        include Decidim::Accountability::BreadcrumbHelper

        def scope
          current_scope.presence if defined?(current_scope)
        end
      end
    end
  end
end
