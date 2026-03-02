# frozen_string_literal: true

module Decidim
  module Initiatives
    module Admin
      module UpdateInitiativeOverride
        extend ActiveSupport::Concern

        included do
          private

          # Override attributes to include new fields
          def attributes
            attrs = {
              title: form.title,
              description: form.description,
              question: form.question,
              definition: form.definition,
              reasons: form.reasons
            }

            if form.signature_type_updatable?
              attrs[:signature_type] = form.signature_type
              attrs[:scoped_type_id] = form.scoped_type_id if form.scoped_type_id
            end

            if current_user.admin?
              add_admin_accessible_attrs(attrs)
            elsif resource.created?
              attrs[:signature_end_date] = form.signature_end_date if resource.custom_signature_end_date_enabled?
              attrs[:decidim_area_id] = form.area_id if resource.area_enabled?
            end

            attrs
          end
        end
      end
    end
  end
end
