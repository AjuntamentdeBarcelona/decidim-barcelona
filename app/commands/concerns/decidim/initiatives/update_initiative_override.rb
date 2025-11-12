# frozen_string_literal: true

module Decidim
  module Initiatives
    module UpdateInitiativeOverride
      extend ActiveSupport::Concern

      included do
        protected

        # Override attributes to include new fields
        def attributes
          attrs = {
            title: { current_locale => form.title },
            description: { current_locale => form.description },
            question: { current_locale => form.question },
            definition: { current_locale => form.definition },
            reasons: { current_locale => form.reasons },
            hashtag: form.hashtag,
            decidim_user_group_id: form.decidim_user_group_id
          }

          if form.signature_type_updatable?
            attrs[:signature_type] = form.signature_type
            attrs[:scoped_type_id] = form.scoped_type_id if form.scoped_type_id
          end

          if initiative.created?
            attrs[:signature_end_date] = form.signature_end_date if initiative.custom_signature_end_date_enabled?
            attrs[:decidim_area_id] = form.area_id if initiative.area_enabled?
          end

          attrs
        end
      end
    end
  end
end
