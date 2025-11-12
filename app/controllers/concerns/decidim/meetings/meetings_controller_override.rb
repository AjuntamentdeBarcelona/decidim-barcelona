# frozen_string_literal: true

module Decidim
  module Meetings
    module MeetingsControllerOverride
      extend ActiveSupport::Concern

      included do
        def show
          raise ActionController::RoutingError, "Not Found" unless meeting

          enforce_permission_to(:read, :meeting, meeting:)

          nil if meeting.visible_for_admin_user?(current_user) || meeting.current_user_can_visit_meeting?(current_user)
        end
      end
    end
  end
end
