# frozen_string_literal: true

module Decidim
  module Accountability
    module Admin
      module ResultsControllerOverride
        extend ActiveSupport::Concern

        included do
          # Same collection as the gem, ordered by the admin-defined position so the
          # admin list matches the public one.
          def collection
            parent_id = params[:parent_id].presence
            @collection ||= Result.where(component: current_component, parent_id:).ordered_by_position.page(params[:page]).per(15)
          end
        end
      end
    end
  end
end
