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
    end
  end
end
