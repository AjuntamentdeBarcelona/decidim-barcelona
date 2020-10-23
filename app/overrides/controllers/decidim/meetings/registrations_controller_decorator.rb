# frozen_string_literal: true

Decidim::Meetings::RegistrationsController.class_eval do
  def create
    enforce_permission_to :register, :meeting, meeting: meeting

    @form = JoinMeetingForm.from_params(params)

    JoinMeeting.call(meeting, current_user, @form) do
      on(:ok) do
        flash[:notice] = I18n.t("registrations.create.success", scope: "decidim.meetings")
        redirect_after_path
      end

      on(:invalid) do
        flash.now[:alert] = I18n.t("registrations.create.invalid", scope: "decidim.meetings")
        redirect_after_path
      end
    end
  end
end
