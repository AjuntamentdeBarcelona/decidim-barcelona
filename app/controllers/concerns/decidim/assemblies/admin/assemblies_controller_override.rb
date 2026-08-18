# frozen_string_literal: true

module Decidim
  module Assemblies
    module Admin
      module AssembliesControllerOverride
        # Backport of https://github.com/decidim/decidim/pull/17500: the children
        # expansion request (JS format) renders no pagination controls, so
        # paginating it made child assemblies beyond the first page unreachable.
        def filtered_collection
          return query.result if request.format.js? && ransack_params[:parent_id_eq].present?

          super
        end
      end
    end
  end
end
