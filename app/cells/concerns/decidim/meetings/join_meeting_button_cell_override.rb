# frozen_string_literal: true

module Decidim
  module Meetings
    module JoinMeetingButtonCellOverride
      extend ActiveSupport::Concern

      included do
        def i18n_join_text
          return I18n.t("register", scope: "decidim.meetings.meetings.show") if model.has_available_slots?

          I18n.t("no_slots_available", scope: "decidim.meetings.meetings.show")
        end
      end
    end
  end
end
