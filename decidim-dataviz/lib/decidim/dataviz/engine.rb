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

      initializer "decidim_dataviz.public" do |app|
        app.middleware.insert_before(::ActionDispatch::Static, ::ActionDispatch::Static, "#{root}/public")
      end

      initializer "decidim_dataviz.webpacker.assets_path" do
        Decidim.register_assets_path File.expand_path("app/packs", root)
      end
    end
  end
end
