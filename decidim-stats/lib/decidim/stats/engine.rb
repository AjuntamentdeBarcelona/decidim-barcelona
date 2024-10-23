# frozen_string_literal: true

module Decidim
  module Stats
    class Engine < ::Rails::Engine
      isolate_namespace Decidim::Stats

      routes do
        resources :authorization_exports, only: [:index, :create]
      end

      initializer "decidim_stats.admin_menus" do
        Decidim.menu :admin_user_menu do |menu|
          menu.add_item :authorization_exports,
                        I18n.t("authorization_exports.menu", scope: "decidim.stats"),
                        decidim_stats.authorization_exports_path,
                        active: is_active_link?(decidim_stats.authorization_exports_path),
                        icon_name: "download-line"
        end
      end
    end
  end
end
