# frozen_string_literal: true

module Decidim
  module PagesControllerOverride
    extend ActiveSupport::Concern

    included do
      before_action :accessibility_redirect

      def accessibility_redirect
        return if params[:id] != "accessibilitat"

        redirect_to "https://ajuntament.barcelona.cat/declaracio-accessibilitat/#{I18n.locale}/decidim-barcelona"
      end
    end
  end
end
