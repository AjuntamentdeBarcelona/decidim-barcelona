# frozen_string_literal: true

module Decidim
  module EphemeralParticipation
    module OrganizationOverride
      extend ActiveSupport::Concern

      included do
        # altough this might introduce some confusion it maintains compatibility accross the application
        # for any code expecting to obtain an array
        def available_authorizations
          authorizations = read_attribute(:available_authorizations)
          authorizations.is_a?(Array) ? authorizations : authorizations.keys
        end

        def ephemeral_participation_authorization
          read_attribute(:available_authorizations).key("allow_ephemeral_participation" => true)
        end
      end
    end
  end
end
