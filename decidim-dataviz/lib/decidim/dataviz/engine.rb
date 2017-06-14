# frozen_string_literal: true

module Decidim
  module Dataviz
    # This is the engine that runs on the public interface of `decidim-dataviz`.
    class Engine < ::Rails::Engine
      isolate_namespace Decidim::Dataviz

      routes do
        resources :dataviz, only: [:index, :show]
        root to: "dataviz#index"
      end

      initializer "decidim_dataviz.assets" do |app|
        app.config.assets.precompile += %w(decidim_dataviz_manifest.js decidim/dataviz/action_plans.csv decidim/dataviz/meetings.csv decidim/dataviz/proposals.csv)
      end

      initializer "decidim_dataviz.public" do |app|
        app.middleware.insert_before(::ActionDispatch::Static, ::ActionDispatch::Static, "#{root}/public")
      end

      initializer "decidim_dataviz.menu" do |_app|
        Decidim.menu :menu do |menu|
          if current_organization.host == "www.decidim.barcelona"
            menu.item I18n.t("decidim.dataviz.menu.accountability_static"),
                      DecidimBarcelona::Application.routes.url_helpers.accountability_static_path,
                      position: 4,
                      active: :inclusive
          end
        end
      end
    end
  end
end
