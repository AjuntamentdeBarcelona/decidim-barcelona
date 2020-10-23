# frozen_string_literal: true



Decidim::Meetings::Meeting.class_eval do
  def can_register_invitation?(user)
    !closed? && registrations_enabled? &&
      can_participate_in_space?(user) && user_has_invitation_for_meeting?(user)
  end

  def user_has_invitation_for_meeting?(user)
    return true unless private_meeting?
    return false unless user

    invites.exists?(decidim_user_id: user.id)
  end
end
