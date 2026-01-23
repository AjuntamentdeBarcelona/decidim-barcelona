# frozen_string_literal: true

module Decidim
  module Initiatives
    module CreateInitiativeOverride
      extend ActiveSupport::Concern

      included do
        private

        # Override to include new fields
        def build_initiative
          @initiative = Initiative.new(
            organization: form.current_organization,
            title: { current_locale => form.title },
            description: { current_locale => form.description },
            question: { current_locale => form.question },
            definition: { current_locale => form.definition },
            reasons: { current_locale => form.reasons },
            has_custom_fields: true,
            author: current_user,
            scoped_type:,
            signature_type: form.type.signature_type,
            decidim_user_group_id: form.decidim_user_group_id,
            decidim_area_id: form.area_id,
            state: "created"
          )
        end
      end
    end
  end
end
