# frozen_string_literal: true

module Decidim
  module System
    class CachesController < Decidim::System::ApplicationController
      # Only routed inside authenticate(:admin) in config/routes.rb, like the rest of decidim-system.
      def destroy # rubocop:disable Decidim/EnforcePermissionTo
        Rails.cache.clear
        flash[:notice] = t("decidim.system.cache.clear_success")
        redirect_to decidim_system.root_path
      end
    end
  end
end
