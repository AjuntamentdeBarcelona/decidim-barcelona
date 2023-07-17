# frozen_string_literal: true

module Decidim
  module ActivitiesCellOverride
    extend ActiveSupport::Concern

    included do
      def activities
        @activities ||= last_activities.select do |activity|
          !activity.respond_to?(:component) || activity.component.published?
        end
      end

      def last_activities
        @last_activities ||= model.map do |activity|
          activity.organization_lazy
          activity.resource_lazy
          activity.participatory_space_lazy
          activity.component_lazy
          activity
        end
      end
    end
  end
end
