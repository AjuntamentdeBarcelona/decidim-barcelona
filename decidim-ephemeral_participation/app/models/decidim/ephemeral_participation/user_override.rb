# frozen_string_literal: true

module Decidim
  module EphemeralParticipation
    module UserOverride
      extend ActiveSupport::Concern

      included do
        scope :ephemeral_participant, -> { managed.where("extended_data ? 'ephemeral_participation'") }

        def ephemeral_participant?
          managed? && ephemeral_participation_data.present?
        end

        def ephemeral_participation_data
          extended_data.fetch("ephemeral_participation", {})
        end

        def verified_ephemeral_participant?
          return false unless ephemeral_participant?

          Decidim::Authorization.exists?(
            user: self,
            name: ephemeral_participation_data["authorization_name"]
          )
        end

        def verifiable_ephemeral_participant?
          return false unless ephemeral_participant?

          Decidim::EphemeralParticipation::VerificationConflicts.for(self).none?
        end

        def unverifiable_ephemeral_participant?
          return false unless ephemeral_participant?

          Decidim::EphemeralParticipation::VerificationConflicts.for(self).any?
        end

        def ephemeral_participation_verification_adapter
          return nil unless ephemeral_participant?

          Decidim::Verifications::Adapter.from_element(ephemeral_participation_data["authorization_name"])
        end
      end
    end
  end
end
