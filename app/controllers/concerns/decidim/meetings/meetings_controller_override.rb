# frozen_string_literal: true

module Decidim
  module Meetings
    module MeetingsControllerOverride
      extend ActiveSupport::Concern

      included do
        # Authorized with allowed_to? (same :read, :meeting check as upstream) instead of
        # enforce_permission_to, to keep the custom alert and redirect to the meetings list.
        def show # rubocop:disable Decidim/EnforcePermissionTo
          raise ActionController::RoutingError, "Not Found" unless meeting

          maybe_show_redirect_notice!

          return if meeting.visible_for_admin_user?(current_user) || allowed_to?(:read, :meeting, meeting:)

          flash[:alert] = I18n.t("meeting.not_allowed", scope: "decidim.meetings")
          redirect_to(ResourceLocatorPresenter.new(meeting).index)
        end
      end
    end
  end
end
