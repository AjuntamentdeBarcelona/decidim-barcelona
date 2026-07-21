# frozen_string_literal: true

module Decidim
  module Admin
    module OfficializationsControllerOverride
      extend ActiveSupport::Concern

      included do
        def resend_invitation
          enforce_permission_to(:invite, :admin_user, user:)

          InviteUserAgain.call(user, "invitation_instructions") do
            on(:ok) do
              flash[:notice] = I18n.t("users.resend_invitation.success", scope: "decidim.admin")
            end

            on(:invalid) do
              flash[:alert] = I18n.t("users.resend_invitation.error", scope: "decidim.admin")
            end
          end

          redirect_to officializations_path
        end
      end
    end
  end
end
