# frozen_string_literal: true

module Decidim
  module EphemeralParticipation
    module ComponentFormOverride
      extend ActiveSupport::Concern

      included do
        validate  :validate_ephemeral_participation_enabled

        private

        def validate_ephemeral_participation_enabled
          return unless settings.try(:ephemeral_participation_enabled) == true
          return if participatory_space.organization.ephemeral_participation_authorization

          settings.errors.add(:ephemeral_participation_enabled, :missing_ephemeral_participation_authorization)
        end
      end
    end
  end
end
