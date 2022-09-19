# frozen_string_literal: true

module Decidim
  module EphemeralParticipation
    module UpdateOrganizationFormOverride
      extend ActiveSupport::Concern

      included do
        alias_method :old_map_model, :map_model

        attribute :available_authorizations, Object

        validate :validate_available_authorizations

        def map_model(model)
          old_map_model(model)
          new_map_model(model)
        end

        def new_map_model(model)
          self.available_authorizations = model.read_attribute(:available_authorizations)
          self.available_authorizations = available_authorizations.index_with { |_a| {} } if available_authorizations.is_a?(Array)
        end

        def clean_available_authorizations
          available_authorizations
        end

        def before_validation
          available_authorizations.transform_values! { |string| JSON.parse(string).presence }.compact!
        end

        private

        def validate_available_authorizations
          return unless available_authorizations.values.count { |hash| hash["allow_ephemeral_participation"] == true } > 1

          errors.add(:available_authorizations, :invalid)
        end
      end
    end
  end
end
