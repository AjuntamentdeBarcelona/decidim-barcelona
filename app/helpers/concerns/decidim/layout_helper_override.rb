# frozen_string_literal: true

module Decidim
  module LayoutHelperOverride
    extend ActiveSupport::Concern

    included do
      # Include NoMethodError as an exception to handle cases where the URL is not available.
      def current_url(params = request.parameters)
        current_url_exceptions = [ActionController::UrlGenerationError, NoMethodError]
        return url_for(params) if respond_to?(:current_participatory_space) || respond_to?(:current_component)

        each_decidim_engine do |helpers|
          return helpers.url_for(params)
        rescue *current_url_exceptions
          # Continue to next engine in case the URL is not available.
        end

        main_app.url_for(params)
      rescue *current_url_exceptions
        "#{request.base_url}#{"?#{params.to_query}" unless params.empty?}"
      end
    end
  end
end
