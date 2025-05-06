# frozen_string_literal: true

module Decidim
  module EphemeralParticipation
    module UpdateOrganizationFormOverride
      extend ActiveSupport::Concern

      included do
        include ActiveModel::Validations::Callbacks

        before_validation :transform_values

        alias_method :old_map_model, :map_model

        attr_reader :available_authorizations_hash

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
          available_authorizations_hash
        end

        def transform_values
          return if available_authorizations.blank?

          @available_authorizations_hash = authorizations_hash(available_authorizations)
        end

        private

        def authorizations_hash(authorizations)
          authorizations.each_with_object({}) do |string, hash|
            parsed_string = transform_value(string)
            next if parsed_string.blank?

            hash[parsed_string[:name]] = parsed_string[:value]
          end
        end

        def transform_value(string)
          return if string.blank?

          hash = JSON.parse(string)
          return if hash.blank? || hash["name"].blank?

          {
            name: hash["name"],
            value: hash.except("name")
          }
        end

        def validate_available_authorizations
          return unless available_authorizations_hash.values.count { |hash| hash["allow_ephemeral_participation"] == true } > 1

          errors.add(:available_authorizations, :invalid)
        end
      end
    end
  end
end
