# frozen_string_literal: true

Decidim::Meetings::HighlightedMeetingsForComponentCell.class_eval do
  def meetings
    @meetings ||= Decidim::Meetings::Meeting.where(component: model).visible_meeting_for(current_user)
  end
end
