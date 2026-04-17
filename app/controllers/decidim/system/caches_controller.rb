# frozen_string_literal: true

module Decidim
  module System
    class CachesController < Decidim::System::ApplicationController
      def destroy
        Rails.cache.clear
        flash[:notice] = t("decidim.system.cache.clear_success")
        redirect_to decidim_system.root_path
      end
    end
  end
end
