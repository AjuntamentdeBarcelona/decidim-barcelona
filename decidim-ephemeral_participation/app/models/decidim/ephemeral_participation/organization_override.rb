# frozen_string_literal: true

module Decidim
  module EphemeralParticipation
    module OrganizationOverride
      extend ActiveSupport::Concern

      included do
        # although this might introduce some confusion it maintains compatibility across the application
        # for any code expecting to obtain an array
        def available_authorizations
          available_authorizations_hash.is_a?(Array) ? available_authorizations_hash : available_authorizations_hash.keys
        end

        def available_authorizations_hash
          @available_authorizations_hash = self[:available_authorizations]
        end

        def ephemeral_participation_authorization
          self[:available_authorizations].key("allow_ephemeral_participation" => true)
        end
      end
    end
  end
end
