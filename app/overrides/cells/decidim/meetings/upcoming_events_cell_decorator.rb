# frozen_string_literal: true

Decidim::Meetings::ContentBlocks::UpcomingEventsCell.class_eval do
  def upcoming_events
    @upcoming_events ||= Decidim::Meetings::Meeting
                         .includes(component: :participatory_space)
                         .where(component: meeting_components)
                         .visible_meeting_for(current_user)
                         .where("end_time >= ?", Time.current)
                         .order(start_time: :asc)
                         .limit(limit)
  end
end
