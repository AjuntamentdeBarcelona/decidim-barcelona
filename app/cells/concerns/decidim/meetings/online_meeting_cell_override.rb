# frozen_string_literal: true

module Decidim
  module Meetings
    module OnlineMeetingCellOverride
      extend ActiveSupport::Concern

      included do
        def bcn_iframe?
          model.online_meeting_url.include?("salavirtual.barcelona.cat")
        end
      end
    end
  end
end
