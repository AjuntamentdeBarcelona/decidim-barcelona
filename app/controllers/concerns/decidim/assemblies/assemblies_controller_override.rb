# frozen_string_literal: true

module Decidim
  module Assemblies
    module AssembliesControllerOverride
      extend ActiveSupport::Concern

      included do
        def per_page
          if Decidim::Paginable::OPTIONS.include?(params[:per_page])
            params[:per_page].to_i
          elsif params[:per_page]
            sorted = Decidim::Paginable::OPTIONS.sort
            params[:per_page].to_i.clamp(sorted.first, sorted.last)
          else
            25
          end
        end
      end
    end
  end
end
