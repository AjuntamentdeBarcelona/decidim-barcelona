# frozen_string_literal: true

module Decidim
  module Accountability
    module Admin
      # This command is executed when the user creates a Result from the admin
      # panel. Inherits from the command defined in Decidim.
      class CreateResultWithExternalId < Admin::CreateResult

        private

        def create_result
          @result = Decidim.traceability.create!(
            ResultWithWeightedProgress,
            @form.current_user,
            feature: @form.current_feature,
            scope: @form.scope,
            category: @form.category,
            parent_id: @form.parent_id,
            title: @form.title,
            description: @form.description,
            start_date: @form.start_date,
            end_date: @form.end_date,
            progress: @form.progress,
            decidim_accountability_status_id: @form.decidim_accountability_status_id,
            external_id: @form.external_id,
            weight: @form.weight
          )
        end
      end
    end
  end
end
