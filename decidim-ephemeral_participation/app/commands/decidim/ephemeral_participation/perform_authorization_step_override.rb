# frozen_string_literal: true

module Decidim
  module EphemeralParticipation
    module PerformAuthorizationStepOverride
      extend ActiveSupport::Concern

      included do
        # TEMPORARY OVERRIDE TO HANDLE VERIFICATION CONFLICTS WITH WORKFLOW AUTHORIZATIONS (MISSING IN DECIDIM)
        # https://github.com/decidim/decidim/pull/6748
        alias :old_call :call

        def call
          if handler.invalid?
            Decidim::Verifications::AuthorizeUser.call(handler)

            broadcast(:invalid)
          else
            old_call
          end
        end
      end
    end
  end
end
