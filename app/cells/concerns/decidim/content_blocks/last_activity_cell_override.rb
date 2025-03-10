# frozen_string_literal: true

module Decidim
  module ContentBlocks
    module LastActivityCellOverride
      extend ActiveSupport::Concern

      included do
        def valid_activities
          return []
          return @valid_activities if defined?(@valid_activities)

          valid_activities_count = 0
          @valid_activities = []
          activities.includes([:user]).each do |activity|
            break if valid_activities_count == activities_to_show

            if activity.visible_for?(current_user) && (!activity.respond_to?(:component) || activity.component&.published?)
              @valid_activities << activity
              valid_activities_count += 1
            end
          end
          @valid_activities
        end
      end
    end
  end
end
