# frozen_string_literal: true

module Decidim
  module Initiatives
    module InitiativeFormOverride
      extend ActiveSupport::Concern

      included do
        attribute :question, String
        attribute :definition, String
        attribute :reasons, String

        # Validate custom fields for new initiatives
        validates :question, :definition, :reasons, presence: true, if: ->(form) { form.context.initiative.nil? || form.context.initiative&.has_custom_fields? }

        def map_model(model)
          self.type_id = model.type.id
          self.scope_id = model.scope&.id
          self.signature_type = model.signature_type || initiative_type.signature_type
          self.title = translated_attribute(model.title)
          self.description = translated_attribute(model.description)
          self.question = translated_attribute(model.question)
          self.definition = translated_attribute(model.definition)
          self.reasons = translated_attribute(model.reasons)
        end
      end

      # Override valid? to set description before validation
      def valid?(context = nil)
        self.description = "-" if description.blank?
        super
      end
    end
  end
end
