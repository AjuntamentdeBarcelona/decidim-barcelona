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

      config.app_middleware.use(Rack::Static, urls: ["/dataviz"], root: Decidim::Dataviz::Engine.root.join("public"))

      initializer "decidim_dataviz.webpacker.assets_path" do
        Decidim.register_assets_path File.expand_path("app/packs", root)
      end
    end
  end
end
