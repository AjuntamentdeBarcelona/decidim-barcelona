# frozen_string_literal: true

module Decidim
  module Meetings
    module MeetingsHelperOverride
      extend ActiveSupport::Concern

      included do
        # Public: Check if any agenda time has a 0 duration with a depth of two levels
        # TODO Implementation as a recursive method so that it takes into account higher levels of depth
        #
        # agendas - Agenda items for the meeting with zero depth
        # meeting - The meeting
        def any_zero_duration_event?(agendas, meeting)
          agenda_items_times = calculate_start_and_end_time_of_agenda_items(agendas, meeting)
          agenda_items_times.any? { |agenda_time| (agenda_time[:start_time] - agenda_time[:end_time]).zero? } ||
            agendas.map.with_index do |agenda, index|
              next unless agenda.agenda_item_children.presence

              parent_start_time = agenda_items_times[index][:start_time]
              agenda_items_children_times = calculate_start_and_end_time_of_agenda_items(agenda.agenda_item_children, meeting, parent_start_time)
              agenda_items_children_times.any? { |agenda_children| (agenda_children[:start_time] - agenda_children[:end_time]).zero? }
            end.include?(true)
        end
      end
    end
  end
end
