# frozen_string_literal: true

module Decidim
  module Meetings
    module MeetingsHelperOverride
      extend ActiveSupport::Concern

      included do
        def search_for_zero_duration_events(agendas_times)
          agendas_times.any? { |agenda_time| agenda_time[:start_time] - agenda_time[:end_time] == 0 }
        end
      end
    end
  end
end