# frozen_string_literal: true

module Decidim
  module EphemeralParticipation
    module PermissionActionOverride
      extend ActiveSupport::Concern

      included do
        def disallowed?
          @state == :disallowed
        end
      end
    end
  end
end
