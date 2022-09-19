# frozen_string_literal: true

module Decidim
  module Overrides
    module Initiatives
      # This cell overrides the Medium (:m) initiative card
      # for an given instance of an Initiative
      module InitiativeMCell
        def statuses
          [:creation_date, :comments_count]
        end
      end
    end
  end
end
