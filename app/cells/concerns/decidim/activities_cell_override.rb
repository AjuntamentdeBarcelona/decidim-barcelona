# frozen_string_literal: true

module Decidim
  module ActivitiesCellOverride
    extend ActiveSupport::Concern

    included do
      def activities
        @activities ||= last_activities.select do |activity|
          activity.visible_for?(current_user) && (!activity.respond_to?(:component) || activity.component.published?)
        end
      end
    end
  end
end
