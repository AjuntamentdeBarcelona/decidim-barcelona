# frozen_string_literal: true

module Decidim
  module EphemeralParticipation
    module ApplicationControllerOverride
      extend ActiveSupport::Concern

      included do
        include Decidim::EphemeralParticipation::EphemeralParticipable
        include Decidim::EphemeralParticipation::NeedsPermissionOverride
      end
    end
  end
end
