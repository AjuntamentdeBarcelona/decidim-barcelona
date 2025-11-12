# frozen_string_literal: true

module Decidim
  module PaginateHelperOverride
    extend ActiveSupport::Concern

    included do
      # Include a condition to force hiding the results per page using a parameter in the paginate_params
      def decidim_paginate(collection, paginate_params = {})
        return if collection.total_pages <= 1

        per_page = (params[:per_page] || paginate_params[:per_page] || Decidim::Paginable::OPTIONS.first).to_i

        content_tag :div, class: "flex flex-col-reverse md:flex-row items-center justify-between gap-1 py-8 md:py-16 md:flex-wrap", data: { pagination: "" } do
          template = ""
          if collection.total_pages.positive? && !paginate_params.delete(:hide_results_per_page_selector)
            template += render partial: "decidim/shared/results_per_page", locals: { per_page: }, formats: [:html]
          end
          template += paginate collection, window: 2, outer_window: 1, theme: "decidim", params: paginate_params
          template.html_safe
        end
      end
    end
  end
end
