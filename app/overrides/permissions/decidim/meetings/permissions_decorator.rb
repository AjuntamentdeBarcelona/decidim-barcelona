# frozen_string_literal: true

Decidim::Meetings::Permissions.class_eval do
  def permissions
    return permission_action unless user

    # Delegate the admin permission checks to the admin permissions class
    return Decidim::Meetings::Admin::Permissions.new(user, permission_action, context).permissions if permission_action.scope == :admin
    return permission_action if permission_action.scope != :public

    return permission_action if permission_action.subject != :meeting

    case permission_action.action
    when :join
      toggle_allow(can_join_meeting?)
    when :leave
      toggle_allow(can_leave_meeting?)
    when :decline_invitation
      toggle_allow(can_decline_invitation?)
    when :register
      toggle_allow(can_register_invitation_meeting?)
    end

    permission_action
  end

  private

  def can_register_invitation_meeting?
    meeting.can_register_invitation?(user) &&
      authorized?(:register, resource: meeting)
  end
end
