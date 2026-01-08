# frozen_string_literal: true

module Decidim
  module Initiatives
    module Admin
      module InitiativeFormOverride
        extend ActiveSupport::Concern

        included do
          translatable_attribute :question, Decidim::Attributes::RichText
          translatable_attribute :definition, Decidim::Attributes::RichText
          translatable_attribute :reasons, Decidim::Attributes::RichText

          validates :question, :definition, :reasons, translatable_presence: true, if: ->(form) { form.context.initiative.has_custom_fields? }
        end

        # Override valid? to set description for new initiatives
        def valid?(context = nil)
          if description.blank?
            current_organization.available_locales.each do |locale|
              description[locale] = "-" if description[locale].blank?
            end
          end
          super
        end
      end
    end
  end
end
