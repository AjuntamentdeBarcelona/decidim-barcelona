# frozen_string_literal: true

module Decidim
  module EphemeralParticipation
    module VerificationsWorkflowManifestOverride
      extend ActiveSupport::Concern

      included do
        # Allows to be configured (in /system) for ephermeral participation (where available)
        attribute :ephemerable, default: false

        def description
          ephemerable_text = ", #{I18n.t("ephemerable", scope: "decidim.authorization_handlers")}" if ephemerable
          "#{fullname} (#{I18n.t(type, scope: "decidim.authorization_handlers")}#{ephemerable_text})"
        end
      end
    end
  end
end

# needs to be available in initializers
Decidim::Verifications::WorkflowManifest.include(Decidim::EphemeralParticipation::VerificationsWorkflowManifestOverride)
