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
    end
  end
end
