# frozen_string_literal: true
module Decidim
  module Debates
    module Admin
      # This class holds a Form to create/update debates from Decidim's admin panel.
      class DebateForm < Decidim::Form
        include TranslatableAttributes

        # TODO: attributes and validates

        def scope
          return unless current_feature
          @scope ||= current_feature.scopes.where(id: decidim_scope_id).first
        end

        def category
          return unless current_feature
          @category ||= current_feature.categories.where(id: decidim_category_id).first
        end
      end
    end
  end
end
