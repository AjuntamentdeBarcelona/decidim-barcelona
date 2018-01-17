# frozen_string_literal: true

module Decidim
  module Accountability
    module Admin
      # This command is executed when the user changes a Result from the admin
      # panel. Inherits from the command defined in Decidim.
      class UpdateResultWithExternalId < Admin::UpdateResult

        private

        def update_result
          Decidim.traceability.update!(
            result,
            form.current_user,
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
