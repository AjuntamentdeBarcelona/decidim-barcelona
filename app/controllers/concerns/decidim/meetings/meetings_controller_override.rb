# frozen_string_literal: true

module Decidim
  module Meetings
    module MeetingsControllerOverride
      extend ActiveSupport::Concern

      included do
        def show
          raise ActionController::RoutingError, "Not Found" unless meeting

          return if meeting.visible_for_admin_user?(current_user) || meeting.current_user_can_visit_meeting?(current_user)

          flash[:alert] = I18n.t("meeting.not_allowed", scope: "decidim.meetings")
          redirect_to(ResourceLocatorPresenter.new(meeting).index)
        end
      end
    end
  end
end
